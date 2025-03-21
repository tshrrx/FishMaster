import 'dart:convert';
import 'package:fishmaster/controllers/weatherController/weatherapiurl.dart';
import 'package:http/http.dart' as http;
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_current.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_daily.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_data.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_hourly.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData?> processData(lat, long) async {
    var response = await http.get(Uri.parse(apiURL(lat, long)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData;
  }
}
