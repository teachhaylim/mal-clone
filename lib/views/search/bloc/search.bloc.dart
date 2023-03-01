import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/bloc_status.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/views/search/helper/args.helper.dart';

part "search.event.dart";
part "search.state.dart";

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();

  SearchBloc({required ArgsHelper filter}) : super(SearchState(filter: filter)) {
    on<SearchGetAnimeEvent>(_searchAnime);
    on<SearchLoadMoreEvent>(_loadMore);
    on<SearchUpdateFilterEvent>(_updateFilter);
  }

  void _searchAnime(SearchGetAnimeEvent event, Emitter<SearchState> emit) async {
    emit(SearchState(status: BlocStatus.initial, filter: state.filter));

    final res = await _searchRequest();

    if (res is ApiErrorResponse) {
      return emit(state.copyWith(status: BlocStatus.error, error: (res as ApiErrorResponse).toCustomError));
    }

    final result = (res as ApiSuccessResponse<BasePaginationResDto<AnimeDto>>).data;
    final lvTotalResults = result.pagination.item?.total ?? 0;
    final lvTotalPages = (lvTotalResults / state.limit).ceil();
    final lvHasMore = state.currentPage < lvTotalPages;

    emit(state.copyWith(hasMore: lvHasMore, totalResults: lvTotalResults, totalPages: lvTotalPages, anime: result.data, status: BlocStatus.loaded));
  }

  void _loadMore(SearchLoadMoreEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: BlocStatus.processing, currentPage: state.currentPage + 1));

    final res = await _searchRequest();

    if (res is ApiErrorResponse) {
      return emit(state.copyWith(status: BlocStatus.error, error: (res as ApiErrorResponse).toCustomError));
    }

    final result = (res as ApiSuccessResponse<BasePaginationResDto<AnimeDto>>).data;
    final lvHasMore = state.currentPage < state.totalPages;

    emit(state.copyWith(hasMore: lvHasMore, anime: state.anime + result.data, status: BlocStatus.loaded));
  }

  void _updateFilter(SearchUpdateFilterEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: BlocStatus.refresh, filter: event.filter));
  }

  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> _searchRequest() {
    return _animeRepo.searchAnime(
      page: state.currentPage,
      searchText: state.filter.searchText,
      type: state.filter.type,
      score: state.filter.score,
      maxScore: state.filter.maxScore,
      minScore: state.filter.minScore,
      airingStatus: state.filter.airingStatus,
      rating: state.filter.rating,
      sfw: state.filter.sfw,
      genres: state.filter.genres,
      genresExclude: state.filter.genreExcludes,
      sortBy: state.filter.sortBy,
      orderBy: state.filter.orderBy,
      letter: state.filter.letter,
      producers: state.filter.producers,
      startDate: state.filter.startDate,
      endDate: state.filter.endDate,
    );
  }
}
