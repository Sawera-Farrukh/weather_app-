// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../constants/colors.dart';
// import '../providers/weather_provider.dart';
// import '../widgets/hourly_forecast.dart';
// import 'search_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<WeatherProvider>(context);

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF2A1454),
//               Color(0xFF1A0B2E),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: provider.isLoading
//               ? const Center(child: CircularProgressIndicator(color: Colors.white))
//               : provider.error != null
//                   ? Center(child: Text(provider.error!, style: const TextStyle(color: Colors.white)))
//                   : Column(
//                       children: [
//                         // Top city name + temperature
//                         const SizedBox(height: 20),
//                         Text(
//                           provider.currentWeather?.city ?? '',
//                           style: const TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '${provider.currentWeather?.temp.round() ?? '--'}°',
//                           style: const TextStyle(
//                             fontSize: 92,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white,
//                             height: 1,
//                           ),
//                         ),
//                         Text(
//                           provider.currentWeather?.description ?? '',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: AppColors.secondaryText,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           'H:${provider.currentWeather?.tempMax.round()}°  L:${provider.currentWeather?.tempMin.round()}°',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: AppColors.secondaryText,
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // ========== HOUSE IMAGE HERE ==========
//                         Expanded(
//                           child: Center(
//                             child: Image.asset(
//                               'assets/images/house.png',   // ← your image path
//                               height: 220,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                         // ======================================

//                         // Hourly / Weekly tabs
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Hourly Forecast',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Text(
//                                 'Weekly Forecast',
//                                 style: TextStyle(
//                                   color: AppColors.secondaryText,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // Hourly list
//                         if (provider.currentWeather != null)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: HourlyForecast(
//                               hourly: provider.currentWeather!.hourly,
//                             ),
//                           ),

//                         const SizedBox(height: 20),

//                         // Bottom navigation bar
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                           height: 70,
//                           decoration: BoxDecoration(
//                             color: AppColors.cardGlass,
//                             borderRadius: BorderRadius.circular(35),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.location_on_outlined, color: Colors.white70),
//                                 onPressed: () {},
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(builder: (_) => const SearchScreen()),
//                                   );
//                                 },
//                                 child: Container(
//                                   width: 56,
//                                   height: 56,
//                                   decoration: const BoxDecoration(
//                                     color: AppColors.primary,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(Icons.add, color: Colors.white, size: 30),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.menu, color: Colors.white70),
//                                 onPressed: () {},
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/weather_provider.dart';
import 'search_screen.dart';
import '../theme/StarrySkyPainter.dart';
import 'dart:ui';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatTime(DateTime time, bool isNow) {
    if (isNow) return 'Now';
    final hour = time.hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '$displayHour $period';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // ========== STARRY SKY BACKGROUND ==========
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1B0B3A), // deep purple
                  Color(0xFF2A1454),
                  Color(0xFF1A0B2E),
                ],
              ),
            ),
          ),
          // Stars layer
          const Positioned.fill(
            child: CustomPaint(
              painter: StarrySkyPainter(),
            ),
          ),
          // ===========================================

          SafeArea(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : provider.error != null
                    ? Center(
                        child: Text(
                          provider.error!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : Column(
                        children: [
                          // Top city name + temperature
                          const SizedBox(height: 20),
                          Text(
                            provider.currentWeather?.city ?? '',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${provider.currentWeather?.temp.round() ?? '--'}°',
                            style: const TextStyle(
                              fontSize: 92,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          Text(
                            provider.currentWeather?.description ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'H:${provider.currentWeather?.tempMax.round()}°  L:${provider.currentWeather?.tempMin.round()}°',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.secondaryText,
                            ),
                          ),

                          const SizedBox(height: 20),


// ========== HOUSE + FORECAST CARD  ==========
Expanded(
  child: LayoutBuilder(
    builder: (context, constraints) {
      final maxH = constraints.maxHeight;

      // These values adapt to screen height
      final houseHeight = maxH * 0.68;   // taller house

      return Stack(
        clipBehavior: Clip.none,
        children: [
Positioned(
  left: 0,
  right: 0,
  top: maxH * 0.12,                    
  bottom: 130,                        
  child: Center(
    child: Image.asset(
      'assets/images/house.png',
      height: houseHeight.clamp(220.0, 340.0), // taller allowed
      fit: BoxFit.contain,
    ),
  ),
),

          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A2A6A).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tabs
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                        child: Row(
                          children: [
                            Text(
                              'Hourly Forecast',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Weekly Forecast',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Hourly list
                      if (provider.currentWeather != null)
                        SizedBox(
                          height: 168,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.currentWeather!.hourly.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final item = provider.currentWeather!.hourly[index];
                              final isNow = index == 0;

                              return Container(
                                width: 68,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isNow
                                      ? const Color(0xFF5C4B9A).withOpacity(0.85)
                                      : Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isNow
                                        ? Colors.white.withOpacity(0.18)
                                        : Colors.transparent,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatTime(item.time, isNow),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${item.icon}@2x.png',
                                      width: 36,
                                      height: 36,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.cloud,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    Text(
                                      '${item.temp.round()}°',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  ),
),







                          // ========== BOTTOM NAVIGATION BAR ==========
                          Container(
                            margin: const EdgeInsets.fromLTRB(24, 4, 24, 20),
                            height: 68,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D1B55).withOpacity(0.85),
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white70,
                                    size: 26,
                                  ),
                                  onPressed: () {},
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SearchScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF7B5CFF),
                                          Color(0xFF5B3FFF),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF7B5CFF).withOpacity(0.5),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white70,
                                    size: 26,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
