class Daily {
  List<String>? time;
  List<int>? swellWaveDirectionDominant;
  List<double>? waveHeightMax;
  List<double>? windWaveHeightMax;
  List<int>? waveDirectionDominant;
  List<num>? wavePeriodMax;
  List<int>? windWaveDirectionDominant;
  List<double>? windWavePeriodMax;
  List<dynamic>? windWavePeakPeriodMax;
  List<double>? swellWaveHeightMax;
  List<dynamic>? swellWavePeriodMax;
  List<dynamic>? swellWavePeakPeriodMax;

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
        time: json['time'] as List<String>?,
        swellWaveDirectionDominant:
            json['swell_wave_direction_dominant'] as List<int>?,
        waveHeightMax: json['wave_height_max'] as List<double>?,
        windWaveHeightMax: json['wind_wave_height_max'] as List<double>?,
        waveDirectionDominant: json['wave_direction_dominant'] as List<int>?,
        wavePeriodMax: json['wave_period_max'] as List<num>?,
        windWaveDirectionDominant:
            json['wind_wave_direction_dominant'] as List<int>?,
        windWavePeriodMax: json['wind_wave_period_max'] as List<double>?,
        windWavePeakPeriodMax:
            json['wind_wave_peak_period_max'] as List<dynamic>?,
        swellWaveHeightMax: json['swell_wave_height_max'] as List<double>?,
        swellWavePeriodMax: json['swell_wave_period_max'] as List<dynamic>?,
        swellWavePeakPeriodMax:
            json['swell_wave_peak_period_max'] as List<dynamic>?,
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
