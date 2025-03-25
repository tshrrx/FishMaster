import 'package:fishmaster/models/Marine/finalmarineData/marine_daily.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourly.dart';
import 'package:fishmaster/models/Marine/marineweather_jsonmapping/current_units.dart';
import 'package:fishmaster/models/Marine/marineweather_jsonmapping/daily_units.dart';
import 'package:fishmaster/models/Marine/marineweather_jsonmapping/hourly_units.dart';

class MarineDataCurrent {
  final Current current;
  MarineDataCurrent({required this.current});
  factory MarineDataCurrent.fromJson(Map<String, dynamic> json) =>
      MarineDataCurrent(current: Current.fromJson(json['current']));
}

class Current {
  String? time;
  int? interval;
  double? seaSurfaceTemperature;
  double? waveHeight;
  int? waveDirection;
  double? windWaveHeight;
  int? swellWaveDirection;
  double? wavePeriod;
  int? windWaveDirection;
  double? windWavePeriod;
  double? swellWavePeriod;
  double? swellWaveHeight;

  Current({
    this.time,
    this.interval,
    this.seaSurfaceTemperature,
    this.waveHeight,
    this.waveDirection,
    this.windWaveHeight,
    this.swellWaveDirection,
    this.wavePeriod,
    this.windWaveDirection,
    this.windWavePeriod,
    this.swellWavePeriod,
    this.swellWaveHeight,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        time: json['time'] as String?,
        interval: json['interval'] as int?,
        seaSurfaceTemperature:
            (json['sea_surface_temperature'] as num?)?.toDouble(),
        waveHeight: (json['wave_height'] as num?)?.toDouble(),
        waveDirection: json['wave_direction'] as int?,
        windWaveHeight: (json['wind_wave_height'] as num?)?.toDouble(),
        swellWaveDirection: json['swell_wave_direction'] as int?,
        wavePeriod: (json['wave_period'] as num?)?.toDouble(),
        windWaveDirection: json['wind_wave_direction'] as int?,
        windWavePeriod: (json['wind_wave_period'] as num?)?.toDouble(),
        swellWavePeriod: (json['swell_wave_period'] as num?)?.toDouble(),
        swellWaveHeight: (json['swell_wave_height'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'interval': interval,
        'sea_surface_temperature': seaSurfaceTemperature,
        'wave_height': waveHeight,
        'wave_direction': waveDirection,
        'wind_wave_height': windWaveHeight,
        'swell_wave_direction': swellWaveDirection,
        'wave_period': wavePeriod,
        'wind_wave_direction': windWaveDirection,
        'wind_wave_period': windWavePeriod,
        'swell_wave_period': swellWavePeriod,
        'swell_wave_height': swellWaveHeight,
      };
}

class Marineweather {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  int? elevation;
  CurrentUnits? currentUnits;
  Current? current;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;
  DailyUnits? dailyUnits;
  Daily? daily;

  Marineweather({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentUnits,
    this.current,
    this.hourlyUnits,
    this.hourly,
    this.dailyUnits,
    this.daily,
  });

  factory Marineweather.fromJson(Map<String, dynamic> json) => Marineweather(
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        generationtimeMs: (json['generationtime_ms'] as num?)?.toDouble(),
        utcOffsetSeconds: json['utc_offset_seconds'] as int?,
        timezone: json['timezone'] as String?,
        timezoneAbbreviation: json['timezone_abbreviation'] as String?,
        elevation: json['elevation'] as int?,
        currentUnits: json['current_units'] == null
            ? null
            : CurrentUnits.fromJson(
                json['current_units'] as Map<String, dynamic>),
        current: json['current'] == null
            ? null
            : Current.fromJson(json['current'] as Map<String, dynamic>),
        hourlyUnits: json['hourly_units'] == null
            ? null
            : HourlyUnits.fromJson(
                json['hourly_units'] as Map<String, dynamic>),
        hourly: json['hourly'] == null
            ? null
            : Hourly.fromJson(json['hourly'] as Map<String, dynamic>),
        dailyUnits: json['daily_units'] == null
            ? null
            : DailyUnits.fromJson(json['daily_units'] as Map<String, dynamic>),
        daily: json['daily'] == null
            ? null
            : Daily.fromJson(json['daily'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationtimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'current_units': currentUnits?.toJson(),
        'current': current?.toJson(),
        'hourly_units': hourlyUnits?.toJson(),
        'hourly': hourly?.toJson(),
        'daily_units': dailyUnits?.toJson(),
        'daily': daily?.toJson(),
      };
}
