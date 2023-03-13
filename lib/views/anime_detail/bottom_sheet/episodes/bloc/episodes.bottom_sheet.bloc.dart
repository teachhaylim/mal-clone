import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/bloc_status.enum.dart';
import 'package:mal_clone/data/models/episode/episode.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';

part "episodes.bottom_sheet.event.dart";
part "episodes.bottom_sheet.state.dart";

class EpisodesBottomSheetBloc extends Bloc<EpisodesBottomSheetEvent, EpisodesBottomSheetState> {
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  final int animeId;

  EpisodesBottomSheetBloc({required this.animeId}) : super(const EpisodesBottomSheetState()) {
    on<EpisodesBottomSheetGetEpisodesEvent>(_getEpisodes);
    on<EpisodesBottomSheetGetMoreEvent>(_getMoreEvent, transformer: droppable());
  }

  void _getEpisodes(EpisodesBottomSheetGetEpisodesEvent event, Emitter<EpisodesBottomSheetState> emit) async {
    emit(const EpisodesBottomSheetState());

    final res = await _animeRepo.getAnimeEpisodes(animeId: animeId);

    if (res is ApiErrorResponse) {
      return emit(state.copyWith(error: (res as ApiErrorResponse).toCustomError, status: BlocStatus.error));
    }

    final result = (res as ApiSuccessResponse<BasePaginationResDto<EpisodeDto>>).data;
    final lvTotalResults = result.pagination.item?.total ?? 0;
    final lvTotalPages = (lvTotalResults / state.limit).ceil();
    final lvHasMore = result.pagination.hasNextPage;

    emit(state.copyWith(
      hasMore: lvHasMore,
      totalResults: lvTotalResults,
      totalPages: lvTotalPages,
      anime: result.data,
      status: BlocStatus.loaded,
    ));
  }

  void _getMoreEvent(EpisodesBottomSheetGetMoreEvent event, Emitter<EpisodesBottomSheetState> emit) async {
    emit(state.copyWith(status: BlocStatus.processing, currentPage: state.currentPage + 1));

    final res = await _animeRepo.getAnimeEpisodes(animeId: animeId, page: state.currentPage);

    if (res is ApiErrorResponse) {
      return emit(state.copyWith(status: BlocStatus.error, error: (res as ApiErrorResponse).toCustomError));
    }

    final result = (res as ApiSuccessResponse<BasePaginationResDto<EpisodeDto>>).data;
    final lvHasMore = result.pagination.hasNextPage;

    emit(state.copyWith(
      hasMore: lvHasMore,
      anime: state.episodes + result.data,
      status: BlocStatus.loaded,
    ));
  }
}
