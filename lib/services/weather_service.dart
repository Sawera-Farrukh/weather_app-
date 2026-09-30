import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // ⬇️ Paste your API key here carefully (no spaces)
  static const String _apiKey = 'Place your API key here'; // ← Replace with your actual API key

  static const String _baseUrl = 'Place your base URL here'; // ← Replace with your actual base URL

  Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse(
      '$_baseUrl/forecast?q=${Uri.encodeComponent(city)}&units=metric&appid=$_apiKey',
    );

    print('Requesting: $url'); // ← useful for debugging

    final response = await http.get(url);

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data, city);
    } else {
      // Show the real error from OpenWeatherMap
      final errorBody = json.decode(response.body);
      final message = errorBody['message'] ?? 'Unknown error';
      throw Exception('Failed to load weather data: $message (code: ${response.statusCode})');
    }
  }
}