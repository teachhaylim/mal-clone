part of "episodes.bottom_sheet.bloc.dart";

abstract class EpisodesBottomSheetEvent extends Equatable {
  const EpisodesBottomSheetEvent();

  @override
  List get props => [];
}

class EpisodesBottomSheetGetEpisodesEvent extends EpisodesBottomSheetEvent {
  const EpisodesBottomSheetGetEpisodesEvent();
}

class EpisodesBottomSheetGetMoreEvent extends EpisodesBottomSheetEvent {
  const EpisodesBottomSheetGetMoreEvent();
}
