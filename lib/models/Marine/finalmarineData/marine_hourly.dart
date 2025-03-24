import 'package:fishmaster/models/Marine/finalmarineData/marine_current.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_daily.dart';

class MarineDataHourly {
  final Hourly hourly;
  MarineDataHourly({required this.hourly});
  factory MarineDataHourly.fromJson(Map<String, dynamic> json) =>
      MarineDataHourly(hourly: Hourly.fromJson(json['hourly']));
}

class Hourly {
  List<String>? time;
  List<num>? waveHeight;
  List<num>? seaSurfaceTemperature;
  List<num>? windWaveHeight;
  List<double>? swellWaveHeight;
  List<num>? wavePeriod;
  List<num>? windWavePeriod;
  List<num>? oceanCurrentVelocity;
  List<int>? oceanCurrentDirection;
  List<int>? waveDirection;
  List<int>? windWaveDirection;
  List<double>? windWavePeakPeriod;
  List<int>? swellWaveDirection;
  List<double>? swellWavePeriod;
  List<double>? swellWavePeakPeriod;
  List<num>? seaLevelHeightMsl;

  Hourly({
    this.time,
    this.waveHeight,
    this.seaSurfaceTemperature,
    this.windWaveHeight,
    this.swellWaveHeight,
    this.wavePeriod,
    this.windWavePeriod,
    this.oceanCurrentVelocity,
    this.oceanCurrentDirection,
    this.waveDirection,
    this.windWaveDirection,
    this.windWavePeakPeriod,
    this.swellWaveDirection,
    this.swellWavePeriod,
    this.swellWavePeakPeriod,
    this.seaLevelHeightMsl,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        time:
            (json['time'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
        waveHeight: (json['wave_height'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        seaSurfaceTemperature:
            (json['sea_surface_temperature'] as List<dynamic>?)
                ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
                .toList(),
        windWaveHeight: (json['wind_wave_height'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        swellWaveHeight: (json['swell_wave_height'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        wavePeriod: (json['wave_period'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        windWavePeriod: (json['wind_wave_period'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        oceanCurrentVelocity: (json['ocean_current_velocity'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        oceanCurrentDirection:
            (json['ocean_current_direction'] as List<dynamic>?)
                ?.map((e) => e as int? ?? 0)
                .toList(),
        waveDirection: (json['wave_direction'] as List<dynamic>?)
            ?.map((e) => e as int? ?? 0)
            .toList(),
        windWaveDirection: (json['wind_wave_direction'] as List<dynamic>?)
            ?.map((e) => e as int? ?? 0)
            .toList(),
        windWavePeakPeriod: (json['wind_wave_peak_period'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        swellWaveDirection: (json['swell_wave_direction'] as List<dynamic>?)
            ?.map((e) => e as int? ?? 0)
            .toList(),
        swellWavePeriod: (json['swell_wave_period'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        swellWavePeakPeriod: (json['swell_wave_peak_period'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        seaLevelHeightMsl: (json['sea_level_height_msl'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'wave_height': waveHeight,
        'sea_surface_temperature': seaSurfaceTemperature,
        'wind_wave_height': windWaveHeight,
        'swell_wave_height': swellWaveHeight,
        'wave_period': wavePeriod,
        'wind_wave_period': windWavePeriod,
        'ocean_current_velocity': oceanCurrentVelocity,
        'ocean_current_direction': oceanCurrentDirection,
        'wave_direction': waveDirection,
        'wind_wave_direction': windWaveDirection,
        'wind_wave_peak_period': windWavePeakPeriod,
        'swell_wave_direction': swellWaveDirection,
        'swell_wave_period': swellWavePeriod,
        'swell_wave_peak_period': swellWavePeakPeriod,
        'sea_level_height_msl': seaLevelHeightMsl,
      };
}

class HourlyUnits {
  String? time;
  String? waveHeight;
  String? seaSurfaceTemperature;
  String? windWaveHeight;
  String? swellWaveHeight;
  String? wavePeriod;
  String? windWavePeriod;
  String? oceanCurrentVelocity;
  String? oceanCurrentDirection;
  String? waveDirection;
  String? windWaveDirection;
  String? windWavePeakPeriod;
  String? swellWaveDirection;
  String? swellWavePeriod;
  String? swellWavePeakPeriod;
  String? seaLevelHeightMsl;

  HourlyUnits({
    this.time,
    this.waveHeight,
    this.seaSurfaceTemperature,
    this.windWaveHeight,
    this.swellWaveHeight,
    this.wavePeriod,
    this.windWavePeriod,
    this.oceanCurrentVelocity,
    this.oceanCurrentDirection,
    this.waveDirection,
    this.windWaveDirection,
    this.windWavePeakPeriod,
    this.swellWaveDirection,
    this.swellWavePeriod,
    this.swellWavePeakPeriod,
    this.seaLevelHeightMsl,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
        time: json['time'] as String?,
        waveHeight: json['wave_height'] as String?,
        seaSurfaceTemperature: json['sea_surface_temperature'] as String?,
        windWaveHeight: json['wind_wave_height'] as String?,
        swellWaveHeight: json['swell_wave_height'] as String?,
        wavePeriod: json['wave_period'] as String?,
        windWavePeriod: json['wind_wave_period'] as String?,
        oceanCurrentVelocity: json['ocean_current_velocity'] as String?,
        oceanCurrentDirection: json['ocean_current_direction'] as String?,
        waveDirection: json['wave_direction'] as String?,
        windWaveDirection: json['wind_wave_direction'] as String?,
        windWavePeakPeriod: json['wind_wave_peak_period'] as String?,
        swellWaveDirection: json['swell_wave_direction'] as String?,
        swellWavePeriod: json['swell_wave_period'] as String?,
        swellWavePeakPeriod: json['swell_wave_peak_period'] as String?,
        seaLevelHeightMsl: json['sea_level_height_msl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'wave_height': waveHeight,
        'sea_surface_temperature': seaSurfaceTemperature,
        'wind_wave_height': windWaveHeight,
        'swell_wave_height': swellWaveHeight,
        'wave_period': wavePeriod,
        'wind_wave_period': windWavePeriod,
        'ocean_current_velocity': oceanCurrentVelocity,
        'ocean_current_direction': oceanCurrentDirection,
        'wave_direction': waveDirection,
        'wind_wave_direction': windWaveDirection,
        'wind_wave_peak_period': windWavePeakPeriod,
        'swell_wave_direction': swellWaveDirection,
        'swell_wave_period': swellWavePeriod,
        'swell_wave_peak_period': swellWavePeakPeriod,
        'sea_level_height_msl': seaLevelHeightMsl,
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
