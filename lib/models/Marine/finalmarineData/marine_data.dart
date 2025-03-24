import 'package:fishmaster/models/Marine/finalmarineData/marine_current.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_currentunits.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_daily.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_dailyunits.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourly.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourlyunits.dart';

class MarineWeatherData {
  final MarineDataCurrent? current;
  final MarineDataHourly? hourly;
  final MarineDataDaily? daily;
  final MarineDataCurrentUnits? currentunits;
  final MarineDataHourlyUnits? hourlyunits;
  final MarineDataDailyUnits? dailyunits;

  MarineWeatherData(
      [this.current,
      this.hourly,
      this.daily,
      this.currentunits,
      this.hourlyunits,
      this.dailyunits]);
  MarineDataCurrent? getCurrentMarineWeather() => current!;
  MarineDataHourly? getHourlyMarineWeather() => hourly!;
  MarineDataDaily? getDailyMarineWeather() => daily!;
  MarineDataCurrentUnits? getCurrentUnitsMarineWeather() => currentunits!;
  MarineDataHourlyUnits? getHourlyUnitsMarineWeather() => hourlyunits!;
  MarineDataDailyUnits? getDailyUnitsMarineWeather() => dailyunits!;
}
