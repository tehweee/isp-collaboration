import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'dart:math' as math; 


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _popController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController _shakeController;
  late Animation<double> _shakeRotationAnimation;

  int _shakeCount = 0; // To keep track of shake repetitions
  final int _maxShakes = 3; // Define how many times to shake

  @override
  void initState() {
    super.initState();

    // --- Pop-up Animation Controller ---
    _popController = AnimationController(
      duration: const Duration(milliseconds: 1000), // Duration for the pop
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _popController,
        curve: Curves.bounceOut, // Pop effect
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _popController,
        curve: Curves.easeOutCubic,
      ),
    );

    // --- Shake Animation Controller ---
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400), // Duration for one shake cycle
      vsync: this,
    );

    _shakeRotationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.05), weight: 0.25), // Tilt right
      TweenSequenceItem(tween: Tween<double>(begin: 0.05, end: -0.05), weight: 0.5), // Tilt left
      TweenSequenceItem(tween: Tween<double>(begin: -0.05, end: 0.0), weight: 0.25), // Back to center
    ]).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.easeInOutSine, // Smooth back and forth
      ),
    );

    // --- Chaining Animations ---
    _popController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // After pop-up completes, start the first shake
        _shakeController.forward(from: 0.0); // Start from beginning
      }
    });

    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeCount++; // Increment shake count
        if (_shakeCount < _maxShakes) {
          // If not reached max shakes, repeat the shake
          _shakeController.forward(from: 0.0); // Reset and play again
        } else {
          // After all shakes complete, navigate
          _navigateToOnboarding();
        }
      }
    });

    // Start the pop-up animation
    _popController.forward();
  }

  _navigateToOnboarding() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC71E1D), // The red background color
      body: Center(
        child: AnimatedBuilder(
          animation: _popController,
          builder: (context, popChild) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.translate(
                offset: _slideAnimation.value * 50,
                child: Opacity(
                  opacity: _popController.value > 0 ? 1.0 : 0.0,
                  child: AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, shakeChild) {
                      return Transform.rotate(
                        angle: _shakeRotationAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/Singaplorer_Logo.png', // Your character image
                              width: 150,
                              height: 150,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Singplorer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}