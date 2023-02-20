// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherServices {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    String baseUrl = 'http://api.weatherapi.com/v1';
    String apiKey = '6f696f713791410eb1b231428230902';
    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    weather = WeatherModel.fromJson(data);
    try {} catch (e) {
      print(e);
    }
    return weather;
  }
}
