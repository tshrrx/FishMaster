import 'package:fishmaster/models/Marine/finalmarineData/marine_current.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_daily.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourly.dart';

class MarineWeatherData {
  final MarineDataCurrent? current;
  final MarineDataHourly? hourly;
  final MarineDataDaily? daily;

  MarineWeatherData([this.current, this.hourly, this.daily]);
  MarineDataCurrent? getCurrentMarineWeather() => current!;
  MarineDataHourly? getHourlyMarineWeather() => hourly!;
  MarineDataDaily? getDailyMarineWeather() => daily!;
}
