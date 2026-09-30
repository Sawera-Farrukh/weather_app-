class WeatherModel {
  final String city;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;
  final List<HourlyWeather> hourly;

  WeatherModel({
    required this.city,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
    required this.hourly,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    final list = json['list'] as List;
    return WeatherModel(
      city: cityName,
      temp: list[0]['main']['temp'].toDouble(),
      tempMin: list[0]['main']['temp_min'].toDouble(),
      tempMax: list[0]['main']['temp_max'].toDouble(),
      description: list[0]['weather'][0]['description'],
      icon: list[0]['weather'][0]['icon'],
      hourly: list.take(8).map((e) => HourlyWeather.fromJson(e)).toList(),
    );
  }
}

class HourlyWeather {
  final DateTime time;
  final double temp;
  final String icon;
  final int humidity;

  HourlyWeather({
    required this.time,
    required this.temp,
    required this.icon,
    required this.humidity,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temp: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
    );
  }
}