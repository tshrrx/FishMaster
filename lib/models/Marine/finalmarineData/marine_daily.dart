import 'package:fishmaster/models/Marine/finalmarineData/marine_current.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_hourly.dart';

class MarineDataDaily {
  final Daily daily;
  MarineDataDaily({required this.daily});
  factory MarineDataDaily.fromJson(Map<String, dynamic> json) =>
      MarineDataDaily(daily: Daily.fromJson(json['daily']));
}

class Daily {
  List<String>? time;
  List<int>? swellWaveDirectionDominant;
  List<double>? waveHeightMax;
  List<double>? windWaveHeightMax;
  List<int>? waveDirectionDominant;
  List<num>? wavePeriodMax;
  List<int>? windWaveDirectionDominant;
  List<double>? windWavePeriodMax;
  List<double>? windWavePeakPeriodMax;
  List<double>? swellWaveHeightMax;
  List<double>? swellWavePeriodMax;
  List<double>? swellWavePeakPeriodMax;

  Daily({
    this.time,
    this.swellWaveDirectionDominant,
    this.waveHeightMax,
    this.windWaveHeightMax,
    this.waveDirectionDominant,
    this.wavePeriodMax,
    this.windWaveDirectionDominant,
    this.windWavePeriodMax,
    this.windWavePeakPeriodMax,
    this.swellWaveHeightMax,
    this.swellWavePeriodMax,
    this.swellWavePeakPeriodMax,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time:
            (json['time'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
        swellWaveDirectionDominant:
            (json['swell_wave_direction_dominant'] as List<dynamic>?)
                ?.map((e) => e as int? ?? 0)
                .toList(),
        waveHeightMax: (json['wave_height_max'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        windWaveHeightMax: (json['wind_wave_height_max'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        waveDirectionDominant:
            (json['wave_direction_dominant'] as List<dynamic>?)
                ?.map((e) => e as int? ?? 0)
                .toList(),
        wavePeriodMax: (json['wave_period_max'] as List<dynamic>?)
            ?.map((e) => (e as num?) ?? 0)
            .toList(),
        windWaveDirectionDominant:
            (json['wind_wave_direction_dominant'] as List<dynamic>?)
                ?.map((e) => e as int? ?? 0)
                .toList(),
        windWavePeriodMax: (json['wind_wave_period_max'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        windWavePeakPeriodMax:
            (json['wind_wave_peak_period_max'] as List<dynamic>?)
                ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
                .toList(),
        swellWaveHeightMax: (json['swell_wave_height_max'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        swellWavePeriodMax: (json['swell_wave_period_max'] as List<dynamic>?)
            ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
            .toList(),
        swellWavePeakPeriodMax:
            (json['swell_wave_peak_period_max'] as List<dynamic>?)
                ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'swell_wave_direction_dominant': swellWaveDirectionDominant,
        'wave_height_max': waveHeightMax,
        'wind_wave_height_max': windWaveHeightMax,
        'wave_direction_dominant': waveDirectionDominant,
        'wave_period_max': wavePeriodMax,
        'wind_wave_direction_dominant': windWaveDirectionDominant,
        'wind_wave_period_max': windWavePeriodMax,
        'wind_wave_peak_period_max': windWavePeakPeriodMax,
        'swell_wave_height_max': swellWaveHeightMax,
        'swell_wave_period_max': swellWavePeriodMax,
        'swell_wave_peak_period_max': swellWavePeakPeriodMax,
      };
}

class DailyUnits {
  String? time;
  String? swellWaveDirectionDominant;
  String? waveHeightMax;
  String? windWaveHeightMax;
  String? waveDirectionDominant;
  String? wavePeriodMax;
  String? windWaveDirectionDominant;
  String? windWavePeriodMax;
  String? windWavePeakPeriodMax;
  String? swellWaveHeightMax;
  String? swellWavePeriodMax;
  String? swellWavePeakPeriodMax;

  DailyUnits({
    this.time,
    this.swellWaveDirectionDominant,
    this.waveHeightMax,
    this.windWaveHeightMax,
    this.waveDirectionDominant,
    this.wavePeriodMax,
    this.windWaveDirectionDominant,
    this.windWavePeriodMax,
    this.windWavePeakPeriodMax,
    this.swellWaveHeightMax,
    this.swellWavePeriodMax,
    this.swellWavePeakPeriodMax,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
        time: json['time'] as String?,
        swellWaveDirectionDominant:
            json['swell_wave_direction_dominant'] as String?,
        waveHeightMax: json['wave_height_max'] as String?,
        windWaveHeightMax: json['wind_wave_height_max'] as String?,
        waveDirectionDominant: json['wave_direction_dominant'] as String?,
        wavePeriodMax: json['wave_period_max'] as String?,
        windWaveDirectionDominant:
            json['wind_wave_direction_dominant'] as String?,
        windWavePeriodMax: json['wind_wave_period_max'] as String?,
        windWavePeakPeriodMax: json['wind_wave_peak_period_max'] as String?,
        swellWaveHeightMax: json['swell_wave_height_max'] as String?,
        swellWavePeriodMax: json['swell_wave_period_max'] as String?,
        swellWavePeakPeriodMax: json['swell_wave_peak_period_max'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'swell_wave_direction_dominant': swellWaveDirectionDominant,
        'wave_height_max': waveHeightMax,
        'wind_wave_height_max': windWaveHeightMax,
        'wave_direction_dominant': waveDirectionDominant,
        'wave_period_max': wavePeriodMax,
        'wind_wave_direction_dominant': windWaveDirectionDominant,
        'wind_wave_period_max': windWavePeriodMax,
        'wind_wave_peak_period_max': windWavePeakPeriodMax,
        'swell_wave_height_max': swellWaveHeightMax,
        'swell_wave_period_max': swellWavePeriodMax,
        'swell_wave_peak_period_max': swellWavePeakPeriodMax,
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
