part of "search.bloc.dart";

class SearchState extends Equatable {
  final int limit = 10;
  final int currentPage;
  final int totalPages;
  final int totalResults;
  final List<AnimeDto> anime;
  final bool hasMore;
  final BlocStatus status;
  final CustomError? error;
  final ArgsHelper filter;

  const SearchState({
    this.anime = const <AnimeDto>[],
    this.currentPage = 1,
    this.totalPages = 0,
    this.totalResults = 0,
    this.hasMore = false,
    this.status = BlocStatus.initial,
    required this.filter,
    this.error,
  });

  SearchState copyWith({
    int? currentPage,
    int? totalPages,
    int? totalResults,
    List<AnimeDto>? anime,
    bool? hasMore,
    BlocStatus? status,
    CustomError? error,
    ArgsHelper? filter,
  }) {
    return SearchState(
      anime: anime ?? this.anime,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      hasMore: hasMore ?? this.hasMore,
      status: status ?? this.status,
      error: error,
      filter: filter ?? this.filter,
    );
  }

  @override
  List get props => [filter, anime, status, hasMore, currentPage, totalPages, totalResults, error];
}
