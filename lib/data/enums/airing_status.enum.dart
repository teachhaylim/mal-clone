enum AiringStatusEnum {
  airing,
  upcoming,
  bypopularity,
  favorite;

  String get toApi {
    switch (this) {
      case airing:
        return "airing";
      case upcoming:
        return "upcoming";
      case bypopularity:
        return "bypopularity";
      case favorite:
        return "favorite";
    }
  }
}
