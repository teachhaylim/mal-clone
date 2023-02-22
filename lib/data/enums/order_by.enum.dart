enum OrderByEnum {
  malId,
  title,
  type,
  rating,
  startDate,
  endDate,
  episodes,
  score,
  scoredBy,
  rank,
  popularity,
  members,
  favorites;

  String get toApi {
    switch (this) {
      case malId:
        return "mal_id";
      case title:
        return "title";
      case type:
        return "type";
      case rating:
        return "rating";
      case startDate:
        return "start_date";
      case endDate:
        return "end_date";
      case episodes:
        return "episodes";
      case score:
        return "score";
      case scoredBy:
        return "scored_by";
      case rank:
        return "rank";
      case popularity:
        return "popularity";
      case members:
        return "members";
      case favorites:
        return "favorites";
    }
  }

  String get toDisplay {
    switch (this) {
      case malId:
        return "MyAnimeList Id";
      case title:
        return "Title";
      case type:
        return "Type";
      case rating:
        return "Rating";
      case startDate:
        return "Start Date";
      case endDate:
        return "End Date";
      case episodes:
        return "Episodes";
      case score:
        return "Score";
      case scoredBy:
        return "Scored By";
      case rank:
        return "Rank";
      case popularity:
        return "Popularity";
      case members:
        return "Members";
      case favorites:
        return "Favorites";
    }
  }
}
