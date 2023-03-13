part of "episodes.bottom_sheet.bloc.dart";

class EpisodesBottomSheetState extends Equatable {
  final BlocStatus status;
  final int totalResults;
  final int currentPage;
  final int totalPages;
  final int limit = 10;
  final List<EpisodeDto> episodes;
  final bool hasMore;
  final CustomError? error;

  const EpisodesBottomSheetState({
    this.status = BlocStatus.initial,
    this.totalResults = 0,
    this.currentPage = 1,
    this.totalPages = 0,
    this.episodes = const <EpisodeDto>[],
    this.hasMore = false,
    this.error,
  });

  EpisodesBottomSheetState copyWith({
    BlocStatus? status,
    int? totalResults,
    int? totalPages,
    int? currentPage,
    List<EpisodeDto>? anime,
    bool? hasMore,
    CustomError? error,
  }) {
    return EpisodesBottomSheetState(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      episodes: anime ?? this.episodes,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }

  @override
  List get props => [status, totalPages, totalResults, currentPage, episodes, hasMore, error];
}
