part of "random.bloc.dart";

abstract class RandomState extends Equatable {
  const RandomState();

  @override
  List get props => [];
}

class RandomInitialState extends RandomState {
  const RandomInitialState();
}

class RandomLoadingState extends RandomState {
  const RandomLoadingState();
}

class RandomLoadedState extends RandomState {
  final AnimeDto anime;
  const RandomLoadedState({required this.anime});

  @override
  List get props => [anime];
}

class RandomErrorState extends RandomState {
  final CustomError error;
  const RandomErrorState({required this.error});

  @override
  List get props => [error];
}
