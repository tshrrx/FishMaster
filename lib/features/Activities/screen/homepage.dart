import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fishmaster/features/Activities/screen/searchPage.dart'; // Import Search Page

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
        distance: '2.5 km away'),
    Fish(
        imageUrl: 'assets/images/Tuna.png',
        name: 'Tuna',
        distance: '3.8 km away'),
    Fish(
        imageUrl: 'assets/images/Trout.png',
        name: 'Trout',
        distance: '1.2 km away'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('FishFinder',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildUserInfo(
                name: "Tejas Balkhande",
                message: "It's a great day to go fishing!"),
            const SizedBox(height: 20),
            _buildLocalWeather({
              'Sea Surface Temp': '25°C',
              'Wind Speed': '10 m/s',
              'Wind Direction': 'NE',
              'Pressure': '1015 hPa',
              'Wave Height': '2.5 m',
              'Cloud Cover': '60%',
            }),
            const SizedBox(height: 10),
            _buildSearchBar(context), // Search Bar Button
            const SizedBox(height: 20),
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

  Widget _buildUserInfo({required String name, required String message}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Hey! ',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(51, 108, 138, 1)),
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(51, 108, 138, 1)),
            ),
          ],
        ),
        const Divider(
            color: Color.fromARGB(255, 107, 107, 107),
            thickness: 0.5,
            height: 10),
        const SizedBox(height: 10),
        Text(message, style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildLocalWeather(Map<String, String> weatherData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Local Weather',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(51, 108, 138, 1)),
          ),
          const SizedBox(height: 8),
          ...weatherData.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('${entry.key}: ${entry.value}',
                  style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchPage()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text("Search for fish or locations...",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(51, 108, 138, 1)),
      ),
    );
  }

  Widget _buildCarousel(List<Fish> fishList) {
    return CarouselSlider.builder(
      itemCount: fishList.length,
      options: CarouselOptions(
        height: 220.0,
        enlargeCenterPage: true,
        autoPlay: true,
        onPageChanged: (index, reason) {
          setState(() => _currentIndex = index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        Fish fish = fishList[index];

        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: AssetImage(fish.imageUrl), // ✅ Only load from assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fish.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(fish.distance,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
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
          width: _currentIndex == index ? 12.0 : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? const Color.fromRGBO(51, 108, 138, 1)
                : Colors.grey,
          ),
        );
      }),
    );
  }
}
