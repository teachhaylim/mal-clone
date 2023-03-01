part of "search.bloc.dart";

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List get props => [];
}

class SearchGetAnimeEvent extends SearchEvent {
  const SearchGetAnimeEvent();
}

class SearchLoadMoreEvent extends SearchEvent {
  const SearchLoadMoreEvent();
}

class SearchUpdateFilterEvent extends SearchEvent {
  final ArgsHelper filter;
  const SearchUpdateFilterEvent({required this.filter});
}
