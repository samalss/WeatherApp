import 'package:weather_api_app/core/constants/api_constants.dart';

import '../../../core/utils/http_client.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final HttpClient httpClient;

  WeatherRepository({required this.httpClient});

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await httpClient.get('/forecast.json', params: {
      'key': ApiConstants.apiKey,
      'q': city,
      'days': '5',
      'lang': 'ru',
    });
    print('Ответ от API: ${response.toString()}');

    return WeatherModel.fromJson(response);
  }
}
