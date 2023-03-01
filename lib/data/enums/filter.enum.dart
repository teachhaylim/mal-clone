enum FilterEnum {
  tv,
  movie,
  ova,
  special,
  ona,
  music;

  String get toApi {
    switch (this) {
      case tv:
        return "tv";
      case movie:
        return "movie";
      case ova:
        return "ova";
      case special:
        return "special";
      case ona:
        return "ona";
      case music:
        return "music";
    }
  }
}
