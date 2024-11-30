import 'package:flutter/material.dart';
import '../../weather/presentation/screens/weather_screen.dart';

class AppRoutes {
  static const String weatherScreen = '/weather';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case weatherScreen:
        return MaterialPageRoute(builder: (_) => WeatherScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Страница не найдена: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
