class MarineDataDailyUnits {
  final DailyUnits dailyunits;
  MarineDataDailyUnits({required this.dailyunits});
  factory MarineDataDailyUnits.fromJson(Map<String, dynamic> json) =>
      MarineDataDailyUnits(
          dailyunits: DailyUnits.fromJson(json['daily_units']));
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
