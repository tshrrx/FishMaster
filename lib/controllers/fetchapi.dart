import 'dart:convert';
import 'package:fishmaster/models/Marine/finalmarineData/marine_currentunits.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_dailyunits.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourlyunits.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_minutely.dart';
import 'package:http/http.dart' as http;
import 'package:fishmaster/controllers/marineweatherController/apiurl.dart'
    as marine_api;
import 'package:fishmaster/controllers/weatherController/weatherapiurl.dart'
    as weather_api;
import 'package:fishmaster/models/Marine/finalmarineData/marine_current.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_daily.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_data.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourly.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_current.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_daily.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_data.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_hourly.dart';
import 'dart:developer';

class FetchAPI {
  Future<MarineWeatherData?> fetchMarineData(double lat, double long) async {
    return await _fetchData<MarineWeatherData>(marine_api.apiURL(lat, long),
        (jsonString) {
      return MarineWeatherData(
        MarineDataCurrent.fromJson(jsonString),
        MarineDataHourly.fromJson(jsonString),
        MarineDataDaily.fromJson(jsonString),
        MarineDataCurrentUnits.fromJson(jsonString),
        MarineDataHourlyUnits.fromJson(jsonString),
        MarineDataDailyUnits.fromJson(jsonString),
      );
    });
  }

  Future<WeatherData?> fetchWeatherData(double lat, double long) async {
    return await _fetchData<WeatherData>(weather_api.apiURL(lat, long),
        (jsonString) {
      return WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString),
        WeatherDataMinutely.fromJson(jsonString),
      );
    });
  }

  Future<T?> _fetchData<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        log("Got response");
        return fromJson(jsonString);
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching data: $e");
    }
    return null;
  }
}
