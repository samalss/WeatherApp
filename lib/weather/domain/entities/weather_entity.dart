import 'forecast_entity.dart';

class WeatherEntity {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final double windSpeed;
  final int humidity;
  final double pressure;
  final ForecastEntity? forecast;

  WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    this.forecast,
  });
}
