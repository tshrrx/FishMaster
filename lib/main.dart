import 'package:fishmaster/features/authentication/screens/signup/signup.dart';
import 'package:fishmaster/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fishmaster/features/authentication/screens/login/login.dart';
import 'package:get/get.dart'; // Import GetX

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: FAppTheme.lightTheme,
      darkTheme: FAppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
      ],
    );
  }
}
