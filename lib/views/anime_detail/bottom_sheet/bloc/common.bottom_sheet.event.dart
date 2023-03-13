part of "common.bottom_sheet.bloc.dart";

abstract class CommonBottomSheetEvent extends Equatable {
  const CommonBottomSheetEvent();

  @override
  List get props => [];
}

class CommonBottomSheetGetPictureEvent extends CommonBottomSheetEvent {
  const CommonBottomSheetGetPictureEvent();
}

class CommonBottomSheetGetThemeSongsEvent extends CommonBottomSheetEvent {
  const CommonBottomSheetGetThemeSongsEvent();
}

class CommonBottomSheetGetStatsRatingEvent extends CommonBottomSheetEvent {
  const CommonBottomSheetGetStatsRatingEvent();
}

class CommonBottomSheetGetEpisodesEvent extends CommonBottomSheetEvent {
  const CommonBottomSheetGetEpisodesEvent();
}

class CommonBottomSheetGetMoreEpisodesEvent extends CommonBottomSheetEvent {
  const CommonBottomSheetGetMoreEpisodesEvent();
}
