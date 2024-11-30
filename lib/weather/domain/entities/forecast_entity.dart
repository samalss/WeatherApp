class ForecastEntity {
  final List<DailyForecast> dailyForecasts;

  ForecastEntity({required this.dailyForecasts});
}

class DailyForecast {
  final String date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String icon;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon,
  });
}
