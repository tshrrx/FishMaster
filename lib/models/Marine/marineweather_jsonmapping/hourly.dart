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
  List<dynamic>? windWavePeakPeriod;
  List<int>? swellWaveDirection;
  List<num>? swellWavePeriod;
  List<dynamic>? swellWavePeakPeriod;
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
        time: json['time'] as List<String>?,
        waveHeight: json['wave_height'] as List<num>?,
        seaSurfaceTemperature: json['sea_surface_temperature'] as List<num>?,
        windWaveHeight: json['wind_wave_height'] as List<num>?,
        swellWaveHeight: json['swell_wave_height'] as List<double>?,
        wavePeriod: json['wave_period'] as List<num>?,
        windWavePeriod: json['wind_wave_period'] as List<num>?,
        oceanCurrentVelocity: json['ocean_current_velocity'] as List<num>?,
        oceanCurrentDirection: json['ocean_current_direction'] as List<int>?,
        waveDirection: json['wave_direction'] as List<int>?,
        windWaveDirection: json['wind_wave_direction'] as List<int>?,
        windWavePeakPeriod: json['wind_wave_peak_period'] as List<dynamic>?,
        swellWaveDirection: json['swell_wave_direction'] as List<int>?,
        swellWavePeriod: json['swell_wave_period'] as List<num>?,
        swellWavePeakPeriod: json['swell_wave_peak_period'] as List<dynamic>?,
        seaLevelHeightMsl: json['sea_level_height_msl'] as List<num>?,
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
