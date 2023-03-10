import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/data/models/streaming_service/streaming_service.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';

part "random.event.dart";
part "random.state.dart";

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final MainRepo _mainRepo = getIt<MainRepo>();
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  // final data = [1, 50709, 5114, 9253, 31964, 20, 1735, 44511];
  late int animeId;

  RandomBloc() : super(const RandomInitialState()) {
    on<RandomGetRandomAnimeEvent>(_getRandomAnime, transformer: droppable());
  }

  void _getRandomAnime(RandomGetRandomAnimeEvent event, Emitter<RandomState> emit) async {
    emit(const RandomLoadingState());

    // animeId = data[Random().nextInt(data.length)];

    final res = await _mainRepo.getRandomAnime();
    // final res = await _animeRepo.getAnimeById(animeId: 30144);

    if (res is ApiErrorResponse) {
      return emit(RandomErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    final animeData = (res as ApiSuccessResponse<AnimeDto>).data;
    animeId = animeData.malId ?? -1;

    await Future.delayed(Duration(seconds: 1), null);

    final streamingServicesRes = await _animeRepo.getAnimeStreamingServices(animeId: animeId);
    final relationsRes = await _animeRepo.getAnimeRelations(animeId: animeId);

    await Future.delayed(Duration(seconds: 1), null);

    final charactersRes = await _animeRepo.getAnimeCharacters(animeId: animeId);

    if (streamingServicesRes is ApiErrorResponse) return emit(RandomErrorState(error: (streamingServicesRes as ApiErrorResponse).toCustomError));

    if (relationsRes is ApiErrorResponse) return emit(RandomErrorState(error: (relationsRes as ApiErrorResponse).toCustomError));

    if (charactersRes is ApiErrorResponse) return emit(RandomErrorState(error: (charactersRes as ApiErrorResponse).toCustomError));

    emit(RandomLoadedState(
      anime: animeData,
      streamingServices: streamingServicesRes is ApiErrorResponse ? [] : (streamingServicesRes as ApiSuccessResponse<List<StreamingServiceDto>>).data,
      relations: relationsRes is ApiErrorResponse ? [] : (relationsRes as ApiSuccessResponse<List<RelationDto>>).data,
      characters: charactersRes is ApiErrorResponse ? [] : (charactersRes as ApiSuccessResponse<List<CharacterDto>>).data,
    ));
  }
}
