import '../entities/weather_entity.dart';
import '../../data/repositories/weather_repository.dart';

class FetchWeatherUseCase {
  final WeatherRepository repository;

  FetchWeatherUseCase({required this.repository});

  Future<WeatherEntity> execute(String city) async {
    return await repository.fetchWeather(city);
  }
}
