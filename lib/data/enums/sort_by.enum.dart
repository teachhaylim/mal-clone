enum SortByEnum {
  asc,
  desc;

  String get toApi {
    switch (this) {
      case asc:
        return "asc";
      case desc:
        return "desc";
    }
  }

  String get toDisplay {
    switch (this) {
      case asc:
        return "Ascending";
      case desc:
        return "Descending";
    }
  }
}
