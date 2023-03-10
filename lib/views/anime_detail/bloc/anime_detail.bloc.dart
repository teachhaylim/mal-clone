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

part "anime_detail.event.dart";
part "anime_detail.state.dart";

class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  final int animeId;

  AnimeDetailBloc({required this.animeId}) : super(const AnimeDetailInitialState()) {
    on<AnimeDetailGetDetailEvent>(_getDetail);
  }

  void _getDetail(AnimeDetailGetDetailEvent event, Emitter<AnimeDetailState> emit) async {
    emit(const AnimeDetailLoadingState());

    final res = await _animeRepo.getAnimeById(animeId: animeId);
    final streamingServicesRes = await _animeRepo.getAnimeStreamingServices(animeId: animeId);

    if (res is ApiErrorResponse) return emit(AnimeDetailErrorState(error: (res as ApiErrorResponse).toCustomError));

    if (streamingServicesRes is ApiErrorResponse) return emit(AnimeDetailErrorState(error: (streamingServicesRes as ApiErrorResponse).toCustomError));

    await Future.delayed(Duration(seconds: 1), null);

    final relationsRes = await _animeRepo.getAnimeRelations(animeId: animeId);
    final charactersRes = await _animeRepo.getAnimeCharacters(animeId: animeId);

    if (relationsRes is ApiErrorResponse) return emit(AnimeDetailErrorState(error: (relationsRes as ApiErrorResponse).toCustomError));

    if (charactersRes is ApiErrorResponse) return emit(AnimeDetailErrorState(error: (charactersRes as ApiErrorResponse).toCustomError));

    emit(AnimeDetailLoadedState(
      anime: (res as ApiSuccessResponse<AnimeDto>).data,
      streamingServices: streamingServicesRes is ApiErrorResponse ? [] : (streamingServicesRes as ApiSuccessResponse<List<StreamingServiceDto>>).data,
      relations: relationsRes is ApiErrorResponse ? [] : (relationsRes as ApiSuccessResponse<List<RelationDto>>).data,
      characters: charactersRes is ApiErrorResponse ? [] : (charactersRes as ApiSuccessResponse<List<CharacterDto>>).data,
    ));
  }
}
