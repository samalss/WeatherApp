import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;
  final VoidCallback onRefresh;
  final DateTime lastUpdated; // Добавлено поле

  const WeatherCard({
    Key? key,
    required this.weather,
    required this.onRefresh,
    required this.lastUpdated, // Обязательно указываем
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Город
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Температура
            Text(
              '${weather.temperature.toStringAsFixed(0)}°C',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Условие погоды
            Text(
              weather.condition,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 14),
            // Иконка погоды
            Image.network(
              'https:${weather.icon}',
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 14),
            // Информация про влажность, ветер и давление
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeatherDetail(
                  icon: Icons.water_drop,
                  label: 'Влажность',
                  value: '${weather.humidity}%',
                ),
                _WeatherDetail(
                  icon: Icons.air,
                  label: 'Ветер',
                  value: '${weather.windSpeed.toStringAsFixed(1)} км/ч',
                ),
                _WeatherDetail(
                  icon: Icons.speed,
                  label: 'Давление',
                  value: '${weather.pressure.toStringAsFixed(1)} мбар',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Прогноз на 5 дней
            if (weather.forecast != null)
              Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          weather.forecast!.dailyForecasts.map((forecast) {
                        // Форматируем день недели
                        final dayOfWeek = DateFormat.E('ru')
                            .format(DateTime.parse(forecast.date));
                        final capitalizedDay =
                            dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              // День недели
                              Text(
                                capitalizedDay, // "Пн", "Вт", и т.д.
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Иконка погоды
                              Image.network(
                                'https:${forecast.icon}', // Иконка из API
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(height: 8),
                              // Температуры
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Ночная температура
                                  Text(
                                    '${forecast.minTemp.toStringAsFixed(0)}°',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 74, 74, 74),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  // Дневная температура
                                  Text(
                                    '${forecast.maxTemp.toStringAsFixed(0)}°',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Text(
              'Последнее обновление: ${DateFormat('HH:mm').format(lastUpdated)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
