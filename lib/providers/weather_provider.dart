import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _service = WeatherService();
  WeatherModel? currentWeather;
  bool isLoading = false;
  String? error;
  String selectedCity = 'Montreal';

  Future<void> fetchWeather([String? city]) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      currentWeather = await _service.getWeather(city ?? selectedCity);
      selectedCity = city ?? selectedCity;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}