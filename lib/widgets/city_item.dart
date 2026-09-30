import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CityItem extends StatelessWidget {
  final String city;
  final double temp;
  final double high;
  final double low;
  final String description;
  final String icon;
  final VoidCallback onTap;

  const CityItem({
    super.key,
    required this.city,
    required this.temp,
    required this.high,
    required this.low,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.cardGlass,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temp.round()}°',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'H:${high.round()}°  L:${low.round()}°',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/$icon@2x.png',
                  width: 60,
                  height: 60,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}