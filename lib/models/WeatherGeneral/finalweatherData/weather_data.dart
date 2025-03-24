import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_current.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_daily.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);
  //fetch
  WeatherDataCurrent? getCurrentWeather() => current!;
  WeatherDataHourly? getHourlyWeather() => hourly!;
  WeatherDataDaily? getDailyWeather() => daily!;
}
