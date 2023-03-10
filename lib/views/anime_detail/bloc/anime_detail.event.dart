part of "anime_detail.bloc.dart";

abstract class AnimeDetailEvent extends Equatable {
  const AnimeDetailEvent();

  @override
  List get props => [];
}

class AnimeDetailGetDetailEvent extends AnimeDetailEvent {
  const AnimeDetailGetDetailEvent();
}
