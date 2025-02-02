import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:demoproject/model/Air_Quality.dart';
import 'package:lottie/lottie.dart';

class AirQualityUi extends StatefulWidget {
  const AirQualityUi({super.key});

  @override
  State<StatefulWidget> createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQualityUi> {
  Air_Quality? air;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const String url =
        'https://api.waqi.info/feed/here/?token=69a32eac5c8927c62a802fba8f907d81e7fd4a34';

    try {
      var response = await http.get(Uri.parse(url));
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          air = Air_Quality.fromJson(jsonList['data']);

          isLoading = false;
        });
      } else {
        errorMessage = 'Failed to load data (Code: ${response.statusCode})';
        isLoading = false;
      }
    } catch (e) {
      errorMessage = 'Error: $e';
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality Index'),
        centerTitle: true,
      ),
       body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              getAQIAnimation(air!.aqi),
              fit: BoxFit.cover,
            ),
          ),
        Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : errorMessage.isNotEmpty
                  ? Text(errorMessage, style: const TextStyle(color: Colors.white))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // เมือง
                        Text(
                          '🌍 ${air!.city}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // AQI Box
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: getAQIColor(air!.aqi),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                air!.aqi.toString(),
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                getAQIStatus(air!.aqi),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Temperature
                        Text(
                          'Temperature: 🌡 ${air!.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(height: 20),

                        // Refresh Button
                        ElevatedButton(
                          onPressed: fetchData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child:  Text('Refresh', style: TextStyle(fontSize: 18, color: Colors.white54)),
                        ),
                      ],
                    ),
        ),
        ],
      ),
    );
  }

  Color getAQIColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  String getAQIStatus(int aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }
  String getAQIAnimation(int aqi) {
    if (aqi <= 100) {
      return 'assets/animations/clean_air.json'; // Animation for clean air
    } else {
      return 'assets/animations/pollution.json'; // Animation for pollution
    }
  }
}
