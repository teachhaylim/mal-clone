import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_data_res/base_data_res.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';

part "random.event.dart";
part "random.state.dart";

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final MainRepo _mainRepo = getIt<MainRepo>();
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();

  RandomBloc() : super(const RandomInitialState()) {
    on<RandomGetRandomAnimeEvent>(_getRandomAnime, transformer: restartable());
  }

  void _getRandomAnime(RandomGetRandomAnimeEvent event, Emitter<RandomState> emit) async {
    emit(const RandomLoadingState());

    final res = await _mainRepo.getRandomAnime();
    // final res = await _animeRepo.getAnimeById(animeId: 1);
    // final res = await _animeRepo.getAnimeById(animeId: 50709);

    if (res is ApiErrorResponse) {
      return emit(RandomErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    emit(RandomLoadedState(anime: (res as ApiSuccessResponse<AnimeDto>).data));
  }
}
