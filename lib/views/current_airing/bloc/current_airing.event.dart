part of "current_airing.bloc.dart";

abstract class CurrentAiringEvent extends Equatable {
  const CurrentAiringEvent();

  @override
  List get props => [];
}

class CurrentAiringGetAiringEvent extends CurrentAiringEvent {
  final String day;
  const CurrentAiringGetAiringEvent({required this.day});
}

class CurrentAiringGetMoreAiringEvent extends CurrentAiringEvent {
  final String day;
  const CurrentAiringGetMoreAiringEvent({required this.day});
}
