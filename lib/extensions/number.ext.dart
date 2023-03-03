extension IntExt on int {
  String get toShorten {
    if (this < 1e3) return "$this";

    if (this >= 1e3 && this <= 1e6) return "${(this / 1e3).round()} K";

    if (this >= 1e6 && this <= 1e9) return "${(this / 1e6).round()} M";

    if (this >= 1e9) return "${(this / 1e9).round()} B";

    return "$this";
  }

  // int get toShortenNum {
  //   if (this < 1e3) return this;

  //   if (this >= 1e3 && this <= 1e6) return (this / 1e3).ceil();

  //   if (this >= 1e6 && this <= 1e9) return (this / 1e6).ceil();

  //   if (this >= 1e9) return (this / 1e9).ceil();

  //   return ceil();
  // }
}
