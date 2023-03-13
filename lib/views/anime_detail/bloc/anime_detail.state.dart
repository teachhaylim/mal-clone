part of "anime_detail.bloc.dart";

abstract class AnimeDetailState extends Equatable {
  const AnimeDetailState();

  @override
  List get props => [];
}

class AnimeDetailInitialState extends AnimeDetailState {
  const AnimeDetailInitialState();
}

class AnimeDetailLoadingState extends AnimeDetailState {
  const AnimeDetailLoadingState();
}

class AnimeDetailLoadedState extends AnimeDetailState {
  final AnimeDto anime;
  final List<StreamingServiceDto> streamingServices;
  final List<RelationDto> relations;
  final List<CharacterDto> characters;
  const AnimeDetailLoadedState({required this.anime, required this.streamingServices, required this.relations, required this.characters});

  @override
  List get props => [anime, streamingServices, relations, characters];
}

class AnimeDetailErrorState extends AnimeDetailState {
  final CustomError error;
  const AnimeDetailErrorState({required this.error});

  @override
  List get props => [error];
}
