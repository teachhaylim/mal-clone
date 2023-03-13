part of "picture.bottom_sheet.bloc.dart";

abstract class PictureBottomSheetEvent extends Equatable {
  const PictureBottomSheetEvent();

  @override
  List get props => [];
}

class PictureBottomSheetGetImagesEvent extends PictureBottomSheetEvent {
  const PictureBottomSheetGetImagesEvent();
}
