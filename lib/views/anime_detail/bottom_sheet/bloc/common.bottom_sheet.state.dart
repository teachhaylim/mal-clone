part of "common.bottom_sheet.bloc.dart";

abstract class CommonBottomSheetState extends Equatable {
  const CommonBottomSheetState();

  @override
  List get props => [];
}

class CommonBottomSheetInitialState extends CommonBottomSheetState {
  const CommonBottomSheetInitialState();
}

class CommonBottomSheetLoadingState extends CommonBottomSheetState {
  const CommonBottomSheetLoadingState();
}

class CommonBottomSheetProcessingState extends CommonBottomSheetState {
  const CommonBottomSheetProcessingState();
}

class CommonBottomSheetPictureLoadedState extends CommonBottomSheetState {
  final List<ImageDto> images;
  const CommonBottomSheetPictureLoadedState({required this.images});

  @override
  List get props => [images];
}

class CommonBottomSheetStatsRatingLoadedState extends CommonBottomSheetState {
  final StatsDto stats;
  const CommonBottomSheetStatsRatingLoadedState({required this.stats});

  @override
  List get props => [stats];
}

class CommonBottomSheetThemeSongsLoadedState extends CommonBottomSheetState {
  final ThemeSongDto themeSong;
  final List<SongDto> openings;
  final List<SongDto> endings;

  const CommonBottomSheetThemeSongsLoadedState({required this.themeSong, required this.endings, required this.openings});

  @override
  List get props => [themeSong, endings, openings];
}

class CommonBottomSheetErrorState extends CommonBottomSheetState {
  final CustomError error;
  const CommonBottomSheetErrorState({required this.error});

  @override
  List get props => [error];
}
