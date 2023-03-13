import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';

part "picture.bottom_sheet.event.dart";
part "picture.bottom_sheet.state.dart";

class PictureBottomSheetBloc extends Bloc<PictureBottomSheetEvent, PictureBottomSheetState> {
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  final int animeId;

  PictureBottomSheetBloc({required this.animeId}) : super(const PictureBottomSheetInitialState()) {
    on<PictureBottomSheetGetImagesEvent>(_getImages);
  }

  void _getImages(PictureBottomSheetGetImagesEvent event, Emitter<PictureBottomSheetState> emit) async {
    emit(const PictureBottomSheetLoadingState());

    final res = await _animeRepo.getAnimeImages(animeId: animeId);

    if (res is ApiErrorResponse) {
      return emit(PictureBottomSheetErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    emit(PictureBottomSheetLoadedState(images: (res as ApiSuccessResponse<List<ImageDto>>).data));
  }
}
