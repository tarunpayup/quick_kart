import 'package:flutter/material.dart';
import 'dart:async';

import 'package:quick_cart/onboardingscreen.dart';

class Splashscreen extends StatefulWidget{
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splashscreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState(){
    super.initState();

    //Animation controller
    _controller = AnimationController(vsync: this,
    duration: const Duration(seconds: 2)
    );

    //fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn)
    );

    //Scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    //Start the animation
    _controller.forward();

    //Splash screen automatically shifts to onboarding screen
    Timer(
      const Duration(seconds: 4), 
      (){
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context)=> const OnboardingScreen()
            )
            );
      }
      );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF064E3B),

      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,

          child: ScaleTransition(
            scale: _scaleAnimation,

            child: const Text(
              'QuickKart',
              style: TextStyle(
                color: Color(0xFF86EFAC),
                fontSize: 42,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
