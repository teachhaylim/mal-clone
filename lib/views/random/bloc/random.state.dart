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
  final List<StreamingServiceDto> streamingServices;
  final List<RelationDto> relations;
  final List<CharacterDto> characters;
  const RandomLoadedState({required this.anime, required this.streamingServices, required this.relations, required this.characters});

  @override
  List get props => [anime, streamingServices, relations, characters];
}

class RandomErrorState extends RandomState {
  final CustomError error;
  const RandomErrorState({required this.error});

  @override
  List get props => [error];
}
