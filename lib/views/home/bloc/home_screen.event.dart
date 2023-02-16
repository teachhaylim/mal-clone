part of "home_screen.bloc.dart";

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List get props => [];
}

class HomeScreenGetGenresEvent extends HomeScreenEvent {
  const HomeScreenGetGenresEvent();
}

class HomeScreenGetSeasonalAnimeEvent extends HomeScreenEvent {
  final SeasonEnum? newSelectedSeason;
  const HomeScreenGetSeasonalAnimeEvent({this.newSelectedSeason});

  @override
  List get props => [newSelectedSeason];
}

class HomeScreenGetTopAnimeEvent extends HomeScreenEvent {
  const HomeScreenGetTopAnimeEvent();
}
