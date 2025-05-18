import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import your splash screen
import 'onboarding_screen.dart'; // Import your onboarding screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Singplorer App',
      debugShowCheckedModeBanner: false, // Set to false to remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.red, // You can customize your app's primary color
        fontFamily: 'Montserrat', // Using Montserrat as a close match for the font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        // You can add more routes here if needed
      },
    );
  }
}