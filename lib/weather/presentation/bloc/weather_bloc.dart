import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../domain/usecases/fetch_weather_usecase.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;
  Timer? _updateTimer;

  WeatherBloc(this.fetchWeatherUseCase) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);

    _startAutoUpdate();
  }

  Future<void> _onFetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await fetchWeatherUseCase.execute(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Ошибка загрузки погоды: $e'));
    }
  }

  void _startAutoUpdate() {
    _updateTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (state is WeatherLoaded) {
        final cityName = (state as WeatherLoaded).weather.cityName;
        add(FetchWeatherEvent(cityName));
      }
    });
  }

  @override
  Future<void> close() {
    _updateTimer?.cancel();
    return super.close();
  }
}
