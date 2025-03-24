class MarineDataCurrentUnits {
  final CurrentUnits currentunits;
  MarineDataCurrentUnits({required this.currentunits});
  factory MarineDataCurrentUnits.fromJson(Map<String, dynamic> json) =>
      MarineDataCurrentUnits(
          currentunits: CurrentUnits.fromJson(json['current_units']));
}

class CurrentUnits {
  String? time;
  String? interval;
  String? seaSurfaceTemperature;
  String? waveHeight;
  String? waveDirection;
  String? windWaveHeight;
  String? swellWaveDirection;
  String? wavePeriod;
  String? windWaveDirection;
  String? windWavePeriod;
  String? swellWavePeriod;
  String? swellWaveHeight;

  CurrentUnits({
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

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => CurrentUnits(
        time: json['time'] as String?,
        interval: json['interval'] as String?,
        seaSurfaceTemperature: json['sea_surface_temperature'] as String?,
        waveHeight: json['wave_height'] as String?,
        waveDirection: json['wave_direction'] as String?,
        windWaveHeight: json['wind_wave_height'] as String?,
        swellWaveDirection: json['swell_wave_direction'] as String?,
        wavePeriod: json['wave_period'] as String?,
        windWaveDirection: json['wind_wave_direction'] as String?,
        windWavePeriod: json['wind_wave_period'] as String?,
        swellWavePeriod: json['swell_wave_period'] as String?,
        swellWaveHeight: json['swell_wave_height'] as String?,
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
