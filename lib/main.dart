import 'package:flutter/material.dart';
import 'package:quick_cart/splashscreen.dart';

void main() {
  runApp(const QuickKartApp());
}

class QuickKartApp extends StatelessWidget{
  const QuickKartApp({super.key});

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splashscreen()
    );
  }
}