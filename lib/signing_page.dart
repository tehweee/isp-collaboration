import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Singplorer App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Montserrat', // You can change to your desired font
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a LayoutBuilder to make the UI responsive to different screen sizes.
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            // Background with gradient
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFDE3131), // Top color (less intense red)
                  Color(0xFFC71E1D), // Bottom color (more intense red)
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.08), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // "Welcome to Singplorer" Text
                  Text(
                    'Welcome to\nSingplorer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxWidth * 0.08, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04), // Responsive spacing

                  // Singplorer Character Image
                  Image.asset(
                    'assets/Singaplorer_Logo.png', // Path to your image asset.  Make sure this is in your assets folder and defined in pubspec.yaml
                    height: constraints.maxHeight * 0.3, // Responsive image height
                    fit: BoxFit.contain, // Ensure the image fits within the given height
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04), // Responsive spacing

                  // "Choose Login or Sign Up" Text
                  Text(
                    'Choose Login or Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxWidth * 0.045, // Responsive font size
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.06), // Responsive spacing

                  // Login Button
                  SizedBox(
                    width: constraints.maxWidth * 0.8, // Responsive button width
                    height: constraints.maxHeight * 0.06, // Responsive button height
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Login button press
                        Navigator.pushNamed(context, '/login'); //  use the correct route
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFFFFF), // White background
                        foregroundColor: const Color(0xFFC71E1D), // Text color: dark red
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02), // Responsive spacing

                  // Sign Up Button
                  SizedBox(
                    width: constraints.maxWidth * 0.8, // Responsive button width
                    height: constraints.maxHeight * 0.06, // Responsive button height
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Sign Up button press
                         Navigator.pushNamed(context, '/signup'); // use the correct route
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC71E1D), // Red background
                        foregroundColor: Colors.white, // White text
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
