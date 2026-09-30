import 'package:flutter/material.dart';
import '../constants/colors.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final double temperature;
  final double high;
  final double low;
  final String description;
  final String iconCode;
  final VoidCallback? onTap;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.high,
    required this.low,
    required this.description,
    required this.iconCode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.cardGlass,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left side - Temperature + City
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temperature.round()}°',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'H:${high.round()}°  L:${low.round()}°',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Right side - Icon + Description
            Column(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/$iconCode@2x.png',
                  width: 70,
                  height: 70,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.wb_cloudy,
                      size: 50,
                      color: Colors.white70,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}