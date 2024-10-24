 import 'package:api_caling/homeScreen.dart';
import 'package:api_caling/photoscreen.dart';
import 'package:api_caling/userpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotoScreen()
    );
  }
}

