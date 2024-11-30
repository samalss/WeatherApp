import '../../domain/entities/weather_entity.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  final DateTime lastUpdated;

  WeatherLoaded(this.weather) : lastUpdated = DateTime.now();
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
