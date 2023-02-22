// Ratings

// G - All Ages
// PG - Children
// PG-13 - Teens 13 or older
// R - 17+ (violence & profanity)
// R+ - Mild Nudity
// Rx - Hentai
enum RatingEnum {
  g,
  pg,
  pgThirteen,
  r,
  rPlus,
  rx;

  String get toApi {
    switch (this) {
      case g:
        return "g";
      case pg:
        return "pg";
      case pgThirteen:
        return "pg-13";
      case r:
        return "r";
      case rPlus:
        return "r+";
      case rx:
        return "rx";
    }
  }

  String get toDisplay {
    switch (this) {
      case g:
        return "G";
      case pg:
        return "PG";
      case pgThirteen:
        return "PG-13";
      case r:
        return "R";
      case rPlus:
        return "R+";
      case rx:
        return "Rx";
    }
  }
}
