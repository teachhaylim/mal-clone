part of "current_airing.bloc.dart";

class CurrentAiringState extends Equatable {
  final BlocStatus status;
  final int totalResults;
  final int currentPage;
  final int totalPages;
  final int limit = 10;
  final List<AnimeDto> anime;
  final bool hasMore;
  final CustomError? error;

  const CurrentAiringState({
    this.status = BlocStatus.initial,
    this.totalResults = 0,
    this.currentPage = 1,
    this.totalPages = 0,
    this.anime = const <AnimeDto>[],
    this.hasMore = false,
    this.error,
  });

  CurrentAiringState copyWith({
    BlocStatus? status,
    int? totalResults,
    int? totalPages,
    int? currentPage,
    List<AnimeDto>? anime,
    bool? hasMore,
    CustomError? error,
  }) {
    return CurrentAiringState(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      anime: anime ?? this.anime,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }

  @override
  List get props => [status, totalPages, totalResults, currentPage, anime, hasMore, error];
}
