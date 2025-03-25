String apiURL(var lat, var long) {
  String url;
  url =
      "https://marine-api.open-meteo.com/v1/marine?latitude=$lat&longitude=$long&daily=swell_wave_direction_dominant,wave_height_max,wind_wave_height_max,wave_direction_dominant,wave_period_max,wind_wave_direction_dominant,wind_wave_period_max,wind_wave_peak_period_max,swell_wave_height_max,swell_wave_period_max,swell_wave_peak_period_max&hourly=wave_height,sea_surface_temperature,wind_wave_height,swell_wave_height,wave_period,wind_wave_period,ocean_current_velocity,ocean_current_direction,wave_direction,wind_wave_direction,wind_wave_peak_period,swell_wave_direction,swell_wave_period,swell_wave_peak_period,sea_level_height_msl&models=best_match&current=sea_surface_temperature,wave_height,wave_direction,wind_wave_height,swell_wave_direction,wave_period,wind_wave_direction,wind_wave_period,swell_wave_period,swell_wave_height&timezone=auto&past_days=2&forecast_days=5";
  return url;
}
