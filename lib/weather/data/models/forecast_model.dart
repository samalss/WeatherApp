import '../../domain/entities/forecast_entity.dart';

class ForecastModel extends ForecastEntity {
  ForecastModel({required List<DailyForecastModel> dailyForecasts})
      : super(dailyForecasts: dailyForecasts);

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final List<DailyForecastModel> forecasts = (json['forecastday'] as List)
        .map((day) => DailyForecastModel.fromJson(day))
        .toList();
    return ForecastModel(dailyForecasts: forecasts);
  }
}

class DailyForecastModel extends DailyForecast {
  DailyForecastModel({
    required String date,
    required double maxTemp,
    required double minTemp,
    required String condition,
    required String icon,
  }) : super(
          date: date,
          maxTemp: maxTemp,
          minTemp: minTemp,
          condition: condition,
          icon: icon,
        );

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
      date: json['date'],
      maxTemp: json['day']['maxtemp_c'],
      minTemp: json['day']['mintemp_c'],
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
    );
  }
}
