import 'package:fishmaster/controllers/fetchapi.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_data.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble lat = 0.0.obs;
  final RxDouble long = 0.0.obs;
  final RxInt currentIndex = 0.obs;

  RxBool checkLoading() => isLoading;
  RxDouble fetchLat() => lat;
  RxDouble fetchLong() => long;
  RxInt getIndext() => currentIndex;

  final marineweatherData = MarineWeatherData().obs;
  final weatherData = WeatherData().obs;

  get marineDataHourly => null;

  WeatherData getData() {
    return weatherData.value;
  }

  MarineWeatherData getMarineData() {
    return marineweatherData.value;
  }

  @override
  void onInit() {
    if (isLoading.isTrue) fetchLocation();
    super.onInit();
  }

  fetchLocation() async {
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error("Location services are disabled!");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location permission denied forever!");
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error("Location permission denied!");
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      print("Raw Position Data: \$position");

      lat.value = position.latitude;
      long.value = position.longitude;

       FetchAPI fetchAPI = FetchAPI();

      try {
      var weather = await fetchAPI.fetchWeatherData(lat.value, long.value);
      if (weather != null) {
        weatherData.value = weather;
        print("Weather data fetched successfully.");
      } else {
        print("Error: Failed to fetch weather data.");
      }
    } catch (e) {
      print("Weather API Error: $e");
    }

    // Fetch marine data with error handling
    try {
      var marine = await fetchAPI.fetchMarineData(lat.value, long.value);
      if (marine != null) {
        marineweatherData.value = marine;
        print("Marine data fetched successfully.");
      } else {
        print("Error: Failed to fetch marine data.");
      }
    } catch (e) {
      print("Marine API Error: $e");
    }

      isLoading.value = false;
    } catch (e) {
      print("Error fetching location: \$egc");
    }
  }
}
