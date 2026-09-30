import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../models/weather_model.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeather> hourly;

  const HourlyForecast({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length,
        itemBuilder: (context, index) {
          final item = hourly[index];
          final isNow = index == 0;

          return Container(
            width: 75,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: isNow ? AppColors.primary.withOpacity(0.4) : AppColors.cardGlass,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isNow ? 'Now' : DateFormat('ha').format(item.time).toLowerCase(),
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${item.icon}@2x.png',
                  width: 40,
                  height: 40,
                ),
                Text(
                  '${item.temp.round()}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}