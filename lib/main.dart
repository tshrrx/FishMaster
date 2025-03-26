import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fishmaster/features/authentication/screens/signup/signup.dart';
import 'package:fishmaster/utils/theme/theme.dart';
import 'package:fishmaster/features/authentication/screens/login/login.dart';
import 'package:fishmaster/features/authentication/screens/signup/otp.dart';
import 'package:fishmaster/features/Activities/controller/homescreen.dart';
import 'package:fishmaster/controllers/global_contoller.dart'; // Ensure this exists
import 'package:fishmaster/features/Activities/alerts/geofence_service.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize GeofenceService asynchronously
  // await Get.putAsync<GeofenceService>(() async {
  //   final service = GeofenceService();
  //   await service.init();
  //   return service;
  // });

  // Ensure GlobalController is initialized before running the app
  Get.put(GlobalController());
  await Get.putAsync(() => GeofenceService().init());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: FAppTheme.lightTheme,
      darkTheme: FAppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/otp', page: () => const OTPVerificationScreen()),
        GetPage(name: '/homescreen', page: () => const HomeScreen()),
      ],
    );
  }
}
