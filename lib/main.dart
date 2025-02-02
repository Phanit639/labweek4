// import 'package:demoproject/homepage.dart';
// import 'package:demoproject/Registraion_Form.dart';
import 'package:demoproject/Weather/AirQualityUi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AirQualityUi(),);
  }
}
