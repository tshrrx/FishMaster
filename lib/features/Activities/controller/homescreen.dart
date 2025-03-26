import 'package:fishmaster/controllers/global_contoller.dart';
import 'package:flutter/material.dart';
import 'package:fishmaster/features/Activities/screen/homepage.dart';
import 'package:fishmaster/features/Activities/screen/profile.dart';
import 'package:fishmaster/features/Activities/screen/searchPage.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  final List<Widget> _pages = [Homepage(), SearchPage(), Profile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (globalController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: _pages[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 0.0, left: 0.0, right: 0.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: SizedBox(
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                indicatorColor: const Color.fromRGBO(51, 108, 138, 1),
                onDestinationSelected: _onItemTapped,
                backgroundColor: Colors.white,
                destinations: [
                  _buildNavItem(Icons.home, "Home", 0),
                  _buildNavItem(Icons.search, "Search", 1),
                  _buildNavItem(Icons.person, "Profile", 2),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.white : Colors.black,
        size: 22,
      ),
      label: label,
    );
  }
}
