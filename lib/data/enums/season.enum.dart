enum SeasonEnum {
  winter,
  spring,
  summer,
  fall;

  String get toDisplayText {
    switch (this) {
      case SeasonEnum.winter:
        return "Winter";
      case SeasonEnum.spring:
        return "Spring";
      case SeasonEnum.summer:
        return "Summer";
      case SeasonEnum.fall:
        return "Fall";
    }
  }

  static SeasonEnum get currentSeason {
    final date = DateTime.now();

    if (date.month >= 1 && date.month <= 3) {
      return SeasonEnum.winter;
    }

    if (date.month >= 4 && date.month <= 6) {
      return SeasonEnum.spring;
    }

    if (date.month >= 7 && date.month <= 9) {
      return SeasonEnum.summer;
    }

    return SeasonEnum.fall;
  }

  static SeasonEnum? parseSeason(String? value) {
    if (value == null) return null;

    switch (value.toLowerCase()) {
      case "winter":
        return SeasonEnum.winter;
      case "spring":
        return SeasonEnum.spring;
      case "summer":
        return SeasonEnum.summer;
      case "fall":
        return SeasonEnum.fall;
      default:
        return null;
    }
  }
}
