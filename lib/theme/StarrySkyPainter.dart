import 'dart:math';
import 'package:flutter/material.dart';

// ========== STARRY SKY PAINTER ==========
class StarrySkyPainter extends CustomPainter {
  const StarrySkyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42); // fixed seed so stars don't jump on rebuild
    final paint = Paint()..color = Colors.white;

    // Draw many small stars
    for (int i = 0; i < 120; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.75; // mostly in upper part
      final radius = random.nextDouble() * 1.4 + 0.3;
      final opacity = random.nextDouble() * 0.7 + 0.3;

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // A few bigger brighter stars
    for (int i = 0; i < 15; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.6;
      paint.color = Colors.white.withOpacity(0.9);
      canvas.drawCircle(Offset(x, y), 1.8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}