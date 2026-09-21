import 'package:flutter/material.dart';
import 'package:quick_cart/screens/onboarding/splashscreen.dart';


void main() {
  runApp(const QuickKartApp());
}

class QuickKartApp extends StatelessWidget{
  const QuickKartApp({super.key});
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splashscreen()
    );
  }
}