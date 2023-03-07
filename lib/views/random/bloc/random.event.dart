part of "random.bloc.dart";

abstract class RandomEvent extends Equatable {
  const RandomEvent();

  @override
  List get props => [];
}

class RandomGetRandomAnimeEvent extends RandomEvent {
  const RandomGetRandomAnimeEvent();
}

// class RandomGetStreamingServicesEvent extends RandomEvent {
//   const RandomGetStreamingServicesEvent();
// }
