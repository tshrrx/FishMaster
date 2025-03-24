class MarineDataHourlyUnits {
  final HourlyUnits hourlyunits;
  MarineDataHourlyUnits({required this.hourlyunits});
  factory MarineDataHourlyUnits.fromJson(Map<String, dynamic> json) =>
      MarineDataHourlyUnits(
          hourlyunits: HourlyUnits.fromJson(json['hourly_units']));
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
