import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String city) async {
    try {
      // 1. Get latitude and longitude from the geocoding API
      final geoUrl = Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1');

      final geoResponse = await http.get(geoUrl);
      if (geoResponse.statusCode != 200) {
        throw Exception('Failed to fetch coordinates');
      }

      final geoData = jsonDecode(geoResponse.body);
      if (geoData['results'] == null || geoData['results'].isEmpty) {
        throw Exception('City not found');
      }

      final lat = geoData['results'][0]['latitude'];
      final lon = geoData['results'][0]['longitude'];

      // 2. Get the current weather using the lat/lon
      final weatherUrl = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true');

      final weatherResponse = await http.get(weatherUrl);
      if (weatherResponse.statusCode != 200) {
        throw Exception('Failed to fetch weather');
      }

      final weatherData = jsonDecode(weatherResponse.body);
      final temperature = weatherData['current_weather']['temperature'];

      // 3. Return real data in Weather model
      return Weather(
        city: city,
        temperature: temperature.toDouble(),
      );
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
}
