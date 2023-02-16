part of "home_screen.bloc.dart";

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List get props => [];
}

class HomeScreenInitialState extends HomeScreenState {
  const HomeScreenInitialState();
}

class HomeScreenLoadingState extends HomeScreenState {
  final HomeScreenSectionEnum section;
  const HomeScreenLoadingState({required this.section});

  @override
  List get props => [section];
}

class HomeScreenGenresLoadedState extends HomeScreenState {
  final List<GenericEntryDto> genres;
  const HomeScreenGenresLoadedState({required this.genres});

  @override
  List get props => [genres];
}

class HomeScreenSeasonalAnimeLoadedState extends HomeScreenState {
  final List<AnimeDto> anime;
  const HomeScreenSeasonalAnimeLoadedState({required this.anime});

  @override
  List get props => [anime];
}

class HomeScreenTopAnimeLoadedState extends HomeScreenState {
  final List<AnimeDto> anime;
  const HomeScreenTopAnimeLoadedState({required this.anime});

  @override
  List get props => [anime];
}

class HomeScreenErrorState extends HomeScreenState {
  final CustomError error;
  final HomeScreenSectionEnum section;
  const HomeScreenErrorState({required this.error, required this.section});

  @override
  List get props => [error, section];
}
