extension IntExt on int {
  String get toShorten {
    if (this < 1e3) return "$this";

    if (this >= 1e3 && this <= 1e6) return "${this / 1e3} K";

    if (this >= 1e6 && this <= 1e9) return "${this / 1e6} M";

    if (this >= 1e9) return "${this / 1e9} B";

    return "$this";
  }
}
