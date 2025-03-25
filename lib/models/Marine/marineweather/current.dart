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
