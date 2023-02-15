enum SeasonEnum {
  winter,
  summer,
  spring,
  fall;

  static SeasonEnum get currentSeason {
    final date = DateTime.now();

    if (date.month >= 1 && date.month <= 3) {
      return SeasonEnum.winter;
    }

    if (date.month >= 4 && date.month <= 6) {
      return SeasonEnum.summer;
    }

    if (date.month >= 7 && date.month <= 9) {
      return SeasonEnum.spring;
    }

    return SeasonEnum.fall;
  }
}
