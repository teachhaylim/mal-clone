import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/bloc_status.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';

part "current_airing.event.dart";
part "current_airing.state.dart";

class CurrentAiringBloc extends Bloc<CurrentAiringEvent, CurrentAiringState> {
  final MainRepo _mainRepo = getIt<MainRepo>();

  CurrentAiringBloc() : super(const CurrentAiringState()) {
    on<CurrentAiringGetAiringEvent>(_getAiringEvent);
    on<CurrentAiringGetMoreAiringEvent>(_getMoreAiringEvent, transformer: droppable());
  }

  void _getAiringEvent(CurrentAiringGetAiringEvent event, Emitter<CurrentAiringState> emit) async {
    emit(const CurrentAiringState());

    final res = await _mainRepo.getAnimeByAiringSchedule(day: event.day, limit: 10, page: state.currentPage);

    if (res is ApiErrorResponse) {
      return emit(state.copyWith(status: BlocStatus.error, error: (res as ApiErrorResponse).toCustomError));
    }

    final result = (res as ApiSuccessResponse<BasePaginationResDto<AnimeDto>>).data;
    final lvTotalResults = result.pagination.item?.total ?? 0;
    final lvTotalPages = (lvTotalResults / state.limit).ceil();
    final lvHasMore = state.currentPage < lvTotalPages;

    emit(state.copyWith(hasMore: lvHasMore, totalResults: lvTotalResults, totalPages: lvTotalPages, anime: result.data, status: BlocStatus.loaded));
  }

  void _getMoreAiringEvent(CurrentAiringGetMoreAiringEvent event, Emitter<CurrentAiringState> emit) async {
    emit(state.copyWith(status: BlocStatus.processing, currentPage: state.currentPage + 1));

    final res = await _mainRepo.getAnimeByAiringSchedule(day: event.day, page: state.currentPage, limit: 10);

    if (res is ApiErrorResponse) {
      return emit(state.copyWith(status: BlocStatus.error, error: (res as ApiErrorResponse).toCustomError));
    }

    final result = (res as ApiSuccessResponse<BasePaginationResDto<AnimeDto>>).data;
    final lvHasMore = state.currentPage < state.totalPages;

    emit(state.copyWith(hasMore: lvHasMore, anime: state.anime + result.data, status: BlocStatus.loaded));
  }
}
