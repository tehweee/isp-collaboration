import 'package:flutter/material.dart';
import 'onboarding_data.dart'; // Import the new data file

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length, // Use the length of your data list
            itemBuilder: (context, index) {
              final pageData = onboardingPages[index];
              return _buildOnboardingPage(
                imagePath: pageData.imagePath,
                title: pageData.title,
                description: pageData.description,
              );
            },
          ),
          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: SafeArea(
              child: TextButton(
                onPressed: () {
                  // Handle skip action, e.g., navigate to home screen
                  print('Skip pressed');
                  // Navigator.pushReplacementNamed(context, '/home'); // Example: Replace with your actual home route
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          // Back Button (conditionally visible)
          if (_currentPage > 0) // Show back button only from the second page onwards
            Positioned(
              top: 40,
              left: 10,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
            ),
          // Bottom Buttons and Page Indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                _buildPageIndicator(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < onboardingPages.length - 1) {
                          // Go to the next page
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        } else {
                          // Last page, navigate to home/login
                          print('Finished onboarding');
                          // Navigator.pushReplacementNamed(context, '/home'); // Example: Replace with your actual home route
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == onboardingPages.length - 1 ? 'Get Started' : 'Next', // Change button text on last page
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // No changes needed here, it dynamically uses the passed data
  Widget _buildOnboardingPage({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              width: 400,
              height: 400,
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()), // Push content up
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingPages.length, (index) {
        return AnimatedContainer( // Use AnimatedContainer for smooth dot transitions
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentPage == index ? 24.0 : 8.0, // Wider dot for current page
          height: 8.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0), // Rounded corners for wider dot
            color: _currentPage == index ? const Color(0xFFC71E1D) : Colors.grey[300],
          ),
        );
      }),
    );
  }
}