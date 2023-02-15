import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';
import 'package:mal_clone/domain/repo/season.repo.dart';

part "home_screen.event.dart";
part "home_screen.state.dart";

enum HomeScreenSectionEnum {
  genre,
  seasonalAnime,
}

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final MainRepo _mainRepo = getIt<MainRepo>();
  final AnimeRepo _animeRepo = getIt<AnimeRepo>();
  final SeasonRepo _seasonRepo = getIt<SeasonRepo>();

  HomeScreenBloc() : super(const HomeScreenInitialState()) {
    on<HomeScreenGetGenresEvent>(_getGenres);
    on<HomeScreenGetSeasonalAnimeEvent>(_getSeasonalAnime);
  }

  void _getGenres(HomeScreenGetGenresEvent event, Emitter<HomeScreenState> emit) async {
    emit(const HomeScreenLoadingState(section: HomeScreenSectionEnum.genre));

    final res = await _mainRepo.getAnimeGenres();

    if (res is ApiErrorResponse) {
      return emit(HomeScreenErrorState(error: (res as ApiErrorResponse).toCustomError, section: HomeScreenSectionEnum.genre));
    }

    return emit(HomeScreenGenresLoadedState(genres: (res as ApiSuccessResponse).data));
  }

  void _getSeasonalAnime(HomeScreenGetSeasonalAnimeEvent event, Emitter<HomeScreenState> emit) async {
    emit(const HomeScreenLoadingState(section: HomeScreenSectionEnum.seasonalAnime));

    final res = await _seasonRepo.getSeasonByYearNSeason(year: DateTime.now().year.toString(), season: SeasonEnum.currentSeason);

    if (res is ApiErrorResponse) {
      return emit(HomeScreenErrorState(error: (res as ApiErrorResponse).toCustomError, section: HomeScreenSectionEnum.seasonalAnime));
    }

    return emit(HomeScreenSeasonalAnimeLoadedState(anime: (res as ApiSuccessResponse<BasePaginationResDto<AnimeDto>>).data.data));
  }
}
