enum SortByEnum {
  asc,
  desc;

  String get toDisplay {
    switch (this) {
      case asc:
        return "Ascending";
      case desc:
        return "Descending";
    }
  }
}
