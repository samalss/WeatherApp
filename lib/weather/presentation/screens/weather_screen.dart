import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/search_city_field.dart';
import '../widgets/weather_card.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.lightBlue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Погода',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SearchCityField(
                  controller: cityController,
                  onSearch: () {
                    final city = cityController.text.trim();
                    if (city.isNotEmpty) {
                      context.read<WeatherBloc>().add(FetchWeatherEvent(city));
                    }
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is WeatherLoaded) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              WeatherCard(
                                weather: state.weather,
                                onRefresh: () {
                                  context.read<WeatherBloc>().add(
                                        FetchWeatherEvent(
                                            state.weather.cityName),
                                      );
                                },
                              ),
                              const SizedBox(height: 10),
                              const Divider(
                                color: Colors.white30,
                                thickness: 1,
                                indent: 50,
                                endIndent: 50,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Данные предоставлены WeatherAPI',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is WeatherError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'Введите город для поиска.',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
