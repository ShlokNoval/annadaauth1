import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart'; // Required for debugPrint()

class WeatherService {
  final String apiKey = "c5ca84df187e5713e0c1fa8ad725b5e0"; // 🔹 Replace with your actual API Key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      // ✅ Get Live Location
      Position position = await getCurrentLocation();
      double latitude = position.latitude;
      double longitude = position.longitude;

      debugPrint("📍 Fetching weather for: $latitude, $longitude");

      // ✅ Fetch Weather Data from OpenWeather API
      final response = await http.get(
        Uri.parse("$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric"),
      );

      debugPrint("🌤 API Response: ${response.body}"); // ✅ Debug log

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint("✅ Weather Updated: ${data['main']['temp']}°C, ${data['weather'][0]['description']}, ${data['name']}");
        return data;
      } else {
        debugPrint("❌ API Error: ${response.statusCode}");
        return {"error": "Failed to fetch weather data"};
      }
    } catch (e) {
      debugPrint("❌ Fetch Error: $e");
      return {"error": "Error fetching weather"};
    }
  }

  // ✅ Get User's Live Location (Latest Geolocator API)
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Check if GPS is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("❌ Location services are disabled.");
      return Future.error("Location services are disabled.");
    }

    // ✅ Check & Request Permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("❌ Location permission denied.");
        return Future.error("Location permission denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint("❌ Location permission permanently denied.");
      return Future.error("Location permissions are permanently denied.");
    }

    // ✅ Get Location with Updated API
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 100,
      ),
    );
  }
}