import '../../domain/entities/weather_entity.dart';
import 'forecast_model.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required String cityName,
    required double temperature,
    required String condition,
    required String icon,
    required double windSpeed,
    required int humidity,
    required double pressure,
    ForecastModel? forecast,
  }) : super(
          cityName: cityName,
          temperature: temperature,
          condition: condition,
          icon: icon,
          windSpeed: windSpeed,
          humidity: humidity,
          pressure: pressure,
          forecast: forecast,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
      windSpeed: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      pressure: json['current']['pressure_mb'],
      forecast: json['forecast'] != null
          ? ForecastModel.fromJson(json['forecast'])
          : null,
    );
  }
}
