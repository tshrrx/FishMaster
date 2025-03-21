import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:untitledwdjwhjhhiwaih/features/Activities/screen/searchPage.dart';

class WeatherData {
  final double temperature;
  final double rainProbability;
  final double windSpeed;

  WeatherData({
    required this.temperature,
    required this.rainProbability,
    required this.windSpeed,
  });
}

class MarineData {
  final double waveHeight;
  final double waterLevel;

  MarineData({
    required this.waveHeight,
    required this.waterLevel,
  });
}

class Fish {
  final String imageUrl;
  final String name;
  final String distance;

  Fish({required this.imageUrl, required this.name, required this.distance});
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Fish> fishList = [
    Fish(
        imageUrl: 'assets/images/Salmon.png',
        name: 'Salmon',
        distance: '2.5 km Away'),
    Fish(
        imageUrl: 'assets/images/Tuna.png',
        name: 'Tuna',
        distance: '3.8 km Away'),
    Fish(
        imageUrl: 'assets/images/Trout.png',
        name: 'Trout',
        distance: '1.2 km Away'),
  ];

  WeatherData? weatherData;
  MarineData? marineData;
  bool isLoading = true;
  String error = '';
  LocationData? currentLocation;

  static const String openWeatherMapKey = "2c6b0fed6195b024d1e9b9144d8dcf2a";
  static const String oneCallUrl =
      "https://api.openweathermap.org/data/3.0/onecall";
  static const String openMeteoMarineUrl =
      "https://marine-api.open-meteo.com/v1/marine";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final location = Location();
    try {
      currentLocation = await location.getLocation();
      await _fetchWeatherData();
      await _fetchMarineData();
    } catch (e) {
      setState(() {
        error = 'Failed to get data: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        '$oneCallUrl?lat=${currentLocation?.latitude ?? 13.0878}&lon=${currentLocation?.longitude ?? 80.2785}&exclude=minutely,hourly&appid=$openWeatherMapKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        weatherData = WeatherData(
          temperature: data['current']['temp'],
          rainProbability: data['current']['rain']?['1h'] ?? 0.0,
          windSpeed: data['current']['wind_speed'],
        );
      });
    }
  }

  Future<void> _fetchMarineData() async {
    final response = await http.get(Uri.parse(
        '$openMeteoMarineUrl?latitude=${currentLocation?.latitude ?? 13.0878}&longitude=${currentLocation?.longitude ?? 80.2785}&current=wave_height,water_level'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        marineData = MarineData(
          waveHeight: data['current']['wave_height'],
          waterLevel: data['current']['water_level'],
        );
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/fisher.png',
          height: 60,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildUserInfo(
              name: "Tejas Balkhande",
              message: "It's a great day to go fishing!",
            ),
            const SizedBox(height: 30),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : error.isNotEmpty
                    ? Center(child: Text(error))
                    : _buildLocalWeather(
                        location: currentLocation != null
                            ? "Current Location"
                            : "Chennai, Tamil Nadu",
                        date: DateFormat('EEE d MMM, y').format(DateTime.now()),
                        temperature:
                            '${weatherData?.temperature.toStringAsFixed(1) ?? '32'}°C',
                        rainProbability:
                            '${weatherData?.rainProbability.toStringAsFixed(0) ?? '20'}%',
                        waveHeight:
                            marineData?.waveHeight.toStringAsFixed(1) ?? '2.5',
                        tideWaterLevel:
                            marineData?.waterLevel.toStringAsFixed(3) ??
                                '0.925',
                        windSpeed:
                            weatherData?.windSpeed.toStringAsFixed(0) ?? '15',
                      ),
            const SizedBox(height: 20),
            _buildSearchBar(context),
            const SizedBox(height: 5),
            _buildLocateFishingAreaButton(),
            const SizedBox(height: 10),
            _buildSectionTitle("Nearby Fishes"),
            const SizedBox(height: 10),
            _buildCarousel(fishList),
            const SizedBox(height: 10),
            _buildIndicator(fishList),
          ],
        ),
      ),
    );
  }

// Keep all other widget building methods same as original
// (_buildUserInfo, _buildWeatherInfo, _buildSearchBar, etc.)
  Widget _buildUserInfo({required String name, required String message}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Hey! ',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey),
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildLocalWeather({
    required String location,
    required String date,
    required String temperature,
    required String rainProbability,
    required String waveHeight,
    required String tideWaterLevel,
    required String windSpeed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location and Date Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 20, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 4), // Spacing between location and date
              Text(
                date,
                style: const TextStyle(
                  fontSize: 16, // Slightly larger for better visibility
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Temperature and Weather Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.thermostat, color: Colors.red, size: 26),
                  const SizedBox(width: 6),
                  Text(
                    temperature,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.wb_sunny, size: 40, color: Colors.amber),
            ],
          ),

          const SizedBox(height: 12),

          // Weather Info (Rain, Waves, Tide, Wind)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherInfo(Icons.water_drop, "Rain", rainProbability),
              _buildWeatherInfo(Icons.waves, "Waves", "$waveHeight m"),
              _buildWeatherInfo(Icons.thermostat, "Tide", "$tideWaterLevel m"),
              _buildWeatherInfo(Icons.air, "Wind", "$windSpeed m/s"),
            ],
          ),

          const SizedBox(height: 11),

          // More Details Button
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // Navigate to detailed weather screen
              },
              child: const Text(
                "More",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 22, color: Colors.blueGrey),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Text(
              "Search for fish or locations...",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocateFishingAreaButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          // Add functionality to locate fishing area
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Color.fromRGBO(51, 108, 138, 1), // Primary theme color
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3, // Adds a subtle shadow
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.location_on,
                color: Colors.white, size: 22), // Location icon
            SizedBox(width: 10),
            Text(
              "Locate Fishing Area",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildCarousel(List<Fish> fishList) {
    return CarouselSlider.builder(
      itemCount: fishList.length,
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) => setState(() => _currentIndex = index),
      ),
      itemBuilder: (context, index, realIndex) {
        Fish fish = fishList[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(fish.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    fish.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    fish.distance,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicator(List<Fish> fishList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(fishList.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentIndex == index ? 10.0 : 6.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.blueGrey : Colors.grey,
          ),
        );
      }),
    );
  }
}
