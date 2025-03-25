import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_current.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_daily.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_hourly.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_minutely.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  final WeatherDataMinutely? minutely;

  WeatherData([this.current, this.hourly, this.daily, this.minutely]);
  WeatherDataCurrent? getCurrentWeather() => current!;
  WeatherDataHourly? getHourlyWeather() => hourly!;
  WeatherDataDaily? getDailyWeather() => daily!;
  WeatherDataMinutely? getMinutelyWeather() => minutely!;
}
