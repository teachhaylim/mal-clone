import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_data_res/base_data_res.dto.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';

part "random.event.dart";
part "random.state.dart";

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final MainRepo _mainRepo = getIt<MainRepo>();

  RandomBloc() : super(const RandomInitialState()) {
    on<RandomGetRandomAnimeEvent>(_getRandomAnime, transformer: restartable());
  }

  void _getRandomAnime(RandomGetRandomAnimeEvent event, Emitter<RandomState> emit) async {
    emit(const RandomLoadingState());

    final res = await _mainRepo.getRandomAnime();

    if (res is ApiErrorResponse) {
      // logger.e(">> error: ${(res as ApiErrorResponse)}");
      return emit(RandomErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    emit(RandomLoadedState(anime: (res as ApiSuccessResponse<BaseDataResDto<AnimeDto>>).data.data));
  }
}
