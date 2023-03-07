import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/data/models/streaming_service/streaming_service.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';

part "random.event.dart";
part "random.state.dart";

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final MainRepo _mainRepo = getIt<MainRepo>();
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  final data = [1, 50709, 5114, 9253, 31964, 20, 1735, 44511];
  late int animeId;

  RandomBloc() : super(const RandomInitialState()) {
    on<RandomGetRandomAnimeEvent>(_getRandomAnime, transformer: droppable());
    // on<RandomGetStreamingServicesEvent>(_getStreamingServices, transformer: droppable());
  }

  void _getRandomAnime(RandomGetRandomAnimeEvent event, Emitter<RandomState> emit) async {
    emit(const RandomLoadingState());

    animeId = data[Random().nextInt(data.length)];

    // final res = await _mainRepo.getRandomAnime();
    // final res = await _animeRepo.getAnimeById(animeId: 11); //NOTE: failed to map error message
    final res = await _animeRepo.getAnimeById(animeId: animeId);
    final streamingServicesRes = await _animeRepo.getAnimeStreamingServices(animeId: animeId);
    final relationsRes = await _animeRepo.getAnimeRelations(animeId: animeId);

    if (res is ApiErrorResponse || streamingServicesRes is ApiErrorResponse || relationsRes is ApiErrorResponse) {
      return emit(RandomErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    emit(RandomLoadedState(
      anime: (res as ApiSuccessResponse<AnimeDto>).data,
      streamingServices: (streamingServicesRes as ApiSuccessResponse<List<StreamingServiceDto>>).data,
      relations: (relationsRes as ApiSuccessResponse<List<RelationDto>>).data,
    ));
  }

  // void _getStreamingServices(RandomGetStreamingServicesEvent event, Emitter<RandomState> emit) async {
  //   final res = await _animeRepo.getAnimeStreamingServices(animeId: selectedAnimeId);
  // }
}
