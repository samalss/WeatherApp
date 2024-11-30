import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_api_app/config/theme/app_theme.dart';
import '/weather/presentation/bloc/weather_bloc.dart';
import '/weather/domain/usecases/fetch_weather_usecase.dart';
import '/weather/data/repositories/weather_repository.dart';
import 'core/utils/http_client.dart';
import 'core/constants/api_constants.dart';
import '/weather/presentation/screens/weather_screen.dart';
import 'config/routes/app_routes.dart';

void main() async {
  final httpClient = HttpClient(baseUrl: ApiConstants.baseUrl);
  final repository = WeatherRepository(httpClient: httpClient);
  final fetchWeatherUseCase = FetchWeatherUseCase(repository: repository);

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);

  runApp(MyApp(fetchWeatherUseCase: fetchWeatherUseCase));
}

class MyApp extends StatelessWidget {
  final FetchWeatherUseCase fetchWeatherUseCase;

  const MyApp({Key? key, required this.fetchWeatherUseCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(fetchWeatherUseCase),
      child: MaterialApp(
        title: 'Weather app',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.weatherScreen,
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        home: WeatherScreen(),
      ),
    );
  }
}
