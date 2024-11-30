import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _checkFirstRun();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Future<void> _checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isOnboarded = prefs.getBool('onboardingCompleted') ?? false;

    // Show Onboarding if it's the first time the app is run
    Timer(const Duration(seconds: 3), () {
      if (!isOnboarded) {
        context.push('/onboarding'); // Navigate to OnboardingPage
      } else {
        context.push('/auth'); // Navigate to HomePage
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF112D4E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: const Icon(
                Icons.shopping_bag,
                size: 100,
                color: Color(0xFFDBE2EF),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                'Market-place',
                style: TextStyle(
                  color: Color(0xFFDBE2EF),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
