import 'dart:convert';
import 'package:fishmaster/controllers/marineweatherController/apiurl.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI{
  WeatherData? weatherData;

  Future<WeatherData?> processData(lat, long) async {
    var response = await http.get(Uri.parse(apiURL(lat, long)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString), WeatherDataDaily.fromJson(jsonString));
      
    
    return weatherData;
  }
}