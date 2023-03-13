part of "picture.bottom_sheet.bloc.dart";

abstract class PictureBottomSheetState extends Equatable {
  const PictureBottomSheetState();

  @override
  List get props => [];
}

class PictureBottomSheetInitialState extends PictureBottomSheetState {
  const PictureBottomSheetInitialState();
}

class PictureBottomSheetLoadingState extends PictureBottomSheetState {
  const PictureBottomSheetLoadingState();
}

class PictureBottomSheetLoadedState extends PictureBottomSheetState {
  final List<ImageDto> images;
  const PictureBottomSheetLoadedState({required this.images});

  @override
  List get props => [images];
}

class PictureBottomSheetErrorState extends PictureBottomSheetState {
  final CustomError error;
  const PictureBottomSheetErrorState({required this.error});

  @override
  List get props => [error];
}
