import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/weather_provider.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';   // ← only this card

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _service = WeatherService();
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  final List<String> popularCities = [
    'Montreal',
    'Toronto',
    'Tokyo',
    'London',
    'New York',
    'Paris',
    'Dubai',
    'Sydney',
  ];

  Future<void> searchCity(String query) async {
    if (query.trim().isEmpty) {
      setState(() => searchResults = []);
      return;
    }

    setState(() => isSearching = true);

    try {
      final weather = await _service.getWeather(query.trim());
      setState(() {
        searchResults = [
          {
            'city': weather.city,
            'temp': weather.temp,
            'high': weather.tempMax,
            'low': weather.tempMin,
            'description': weather.description,
            'icon': weather.icon,
          }
        ];
      });
    } catch (e) {
      setState(() => searchResults = []);
    } finally {
      setState(() => isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A1454),
              Color(0xFF1A0B2E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Weather',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search for a city or airport',
                    hintStyle: TextStyle(color: AppColors.secondaryText),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.cardGlass,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onSubmitted: searchCity,
                  textInputAction: TextInputAction.search,
                ),
              ),

              // Results
              Expanded(
                child: isSearching
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        children: [
                          // ===== Search Results =====
                          if (searchResults.isNotEmpty)
                            ...searchResults.map((item) {
                              return WeatherCard(
                                city: item['city'],
                                temperature: item['temp'],
                                high: item['high'],
                                low: item['low'],
                                description: item['description'],
                                iconCode: item['icon'],
                                onTap: () {
                                  provider.fetchWeather(item['city']);
                                  Navigator.pop(context);
                                },
                              );
                            }),

                          // ===== Popular Cities =====
                          if (searchResults.isEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text(
                                'Popular Cities',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ...popularCities.map((city) {
                              return FutureBuilder(
                                future: _service.getWeather(city),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox(
                                      height: 110,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white54,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  }

                                  if (!snapshot.hasData || snapshot.hasError) {
                                    return const SizedBox.shrink();
                                  }

                                  final weather = snapshot.data!;

                                  return WeatherCard(
                                    city: weather.city,
                                    temperature: weather.temp,
                                    high: weather.tempMax,
                                    low: weather.tempMin,
                                    description: weather.description,
                                    iconCode: weather.icon,
                                    onTap: () {
                                      provider.fetchWeather(weather.city);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            }),
                          ],
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}