String apiURL(var lat, var long) {
  String url;
  url = "https://marine-api.open-meteo.com/v1/marine?latitude=$lat&longitude=$long&daily=wave_height_max,wind_wave_height_max,wave_direction_dominant,wave_period_max,swell_wave_height_max,swell_wave_direction_dominant,swell_wave_period_max,sea_level_height_msl&hourly=wave_height,sea_surface_temperature,wind_wave_height,swell_wave_height,wave_period,wind_wave_period,wave_direction,wind_wave_direction,swell_wave_direction,swell_wave_period,sea_level_height_msl&current=sea_surface_temperature,wave_height,wave_direction,wind_wave_height,swell_wave_direction,wave_period,wind_wave_direction,wind_wave_period,swell_wave_period,swell_wave_height&models=best_match&timezone=auto&past_days=2&forecast_days=5";
  return url;
}
