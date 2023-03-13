import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/data/models/song/song.dto.dart';
import 'package:mal_clone/data/models/theme_song/theme_song.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';

part "common.bottom_sheet.event.dart";
part "common.bottom_sheet.state.dart";

class CommonBottomSheetBloc extends Bloc<CommonBottomSheetEvent, CommonBottomSheetState> {
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  final int animeId;

  CommonBottomSheetBloc({required this.animeId}) : super(const CommonBottomSheetInitialState()) {
    on<CommonBottomSheetGetPictureEvent>(_getPicture);
    on<CommonBottomSheetGetStatsRatingEvent>(_getStatsRating);
    on<CommonBottomSheetGetThemeSongsEvent>(_getThemeSongs);
    on<CommonBottomSheetGetEpisodesEvent>(_getEpisodes);
    on<CommonBottomSheetGetMoreEpisodesEvent>(_getMoreEpisodes);
  }

  void _getPicture(CommonBottomSheetGetPictureEvent event, Emitter<CommonBottomSheetState> emit) async {
    emit(const CommonBottomSheetLoadingState());

    final res = await _animeRepo.getAnimeImages(animeId: animeId);

    if (res is ApiErrorResponse) {
      return emit(CommonBottomSheetErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    emit(CommonBottomSheetPictureLoadedState(images: (res as ApiSuccessResponse<List<ImageDto>>).data));
  }

  void _getStatsRating(CommonBottomSheetGetStatsRatingEvent event, Emitter<CommonBottomSheetState> emit) async {}

  void _getThemeSongs(CommonBottomSheetGetThemeSongsEvent event, Emitter<CommonBottomSheetState> emit) async {
    emit(const CommonBottomSheetLoadingState());

    final res = await _animeRepo.getAnimeThemeSongs(animeId: animeId);

    if (res is ApiErrorResponse) {
      return emit(CommonBottomSheetErrorState(error: (res as ApiErrorResponse).toCustomError));
    }

    final themeSong = (res as ApiSuccessResponse<ThemeSongDto>).data;

    emit(CommonBottomSheetThemeSongsLoadedState(
      themeSong: themeSong,
      openings: themeSong.toOpeningSongs,
      endings: themeSong.toEndingSongs,
    ));
  }

  void _getEpisodes(CommonBottomSheetGetEpisodesEvent event, Emitter<CommonBottomSheetState> emit) async {}

  void _getMoreEpisodes(CommonBottomSheetGetMoreEpisodesEvent event, Emitter<CommonBottomSheetState> emit) async {}
}
