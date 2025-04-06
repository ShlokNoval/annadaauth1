import 'package:annadaauth1/screens/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/weather_service.dart';
import '../screens/gemini_page.dart';
import '../screens/Fertilizer_calculator.dart';
import '../screens/profile_page.dart';
import '../screens/yojna_page.dart';
import '../screens/notification_service.dart';
import '../screens/image_detection.dart';
import '../screens/nearnessofmarket.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> weatherFuture;
  String _userName = "";
  String _phoneNumber = "";
  String? _profilePhoto;
  bool _showWelcome = false;

  @override
  void initState() { 
    super.initState();
    weatherFuture = _getWeather();
    _loadProfileData();
  }

  Future<Map<String, dynamic>> _getWeather() async {
    final weatherService = WeatherService();
    try {
      final weatherData = await weatherService.fetchWeather();

      if (weatherData.containsKey("main")) {
        double temp = double.tryParse(weatherData['main']['temp'].toString()) ?? 0;

        // 🔔 Trigger notifications
        if (temp > 35) {
          NotificationService.showWeatherAlert(
            "☀️ High Temperature Alert!",
            "It's too hot today: ${temp.toStringAsFixed(1)}°C. Stay hydrated!",
          );
        } else if (temp < 10) {
          NotificationService.showWeatherAlert(
            "❄️ Low Temperature Alert!",
            "It's very cold: ${temp.toStringAsFixed(1)}°C. Stay warm!",
          );
        }
      }

      return weatherData.containsKey("error")
          ? {
        "temp": "❌",
        "desc": "Could not fetch weather",
        "location": "Check API Key & Location"
      }
          : {
        "temp": "${weatherData['main']['temp']}°C",
        "desc": weatherData['weather'][0]['description'].toString(),
        "location": weatherData['name'].toString(),
      };
    } catch (e) {
      return {
        "temp": "❌",
        "desc": "Location/Weather issue",
        "location": e.toString()
      };
    }
  }


  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? "";
      _phoneNumber = prefs.getString('phoneNumber') ?? "";
      _profilePhoto = prefs.getString('profilePhoto');
      _showWelcome = _userName.isNotEmpty;
    });

    if (_showWelcome) {
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          _showWelcome = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 2,
        title: Text("Your Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              _loadProfileData();
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: _profilePhoto != null ? NetworkImage(
                    _profilePhoto!) : null,
                child: _profilePhoto == null ? Icon(
                    Icons.person, size: 30, color: Colors.green) : null,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_showWelcome)
              AnimatedOpacity(
                opacity: _showWelcome ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.eco, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Welcome, $_userName!",
                        style: TextStyle(color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            FutureBuilder<Map<String, dynamic>>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildWeatherBox(
                      "Fetching location...", "Loading...", "Please wait...");
                } else if (snapshot.hasError) {
                  return _buildWeatherBox(
                      "Error", "❌", "Could not load weather");
                } else {
                  var data = snapshot.data ?? {};
                  return _buildWeatherBox(
                      data["location"], data["temp"], data["desc"]);
                }
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  weatherFuture = _getWeather();
                });
              },
              icon: Icon(Icons.refresh),
              label: Text("Refresh Weather"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildFeatureBox(
                      "Fertilizer Calculator", FontAwesomeIcons.seedling),
                  _buildFeatureBox("Crop Detection", FontAwesomeIcons.camera),
                  _buildFeatureBox(
                      "Market Connectivity", FontAwesomeIcons.mapLocationDot),
                  _buildFeatureBox("Tutorial", FontAwesomeIcons.bookOpen),
                  _buildFeatureBox("Yojna", FontAwesomeIcons.handshake),
                  _buildFeatureBox("Annada Assistant", FontAwesomeIcons.robot),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherBox(String location, String temperature,
      String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 6, spreadRadius: 2)
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.wb_sunny, size: 40, color: Colors.yellow),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                temperature,
                style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBox(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == "Annada Assistant") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GeminiPage()));
        } else if (title == "Fertilizer Calculator") {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => FertilizerCalculatorPage()));
        } else if (title == "Yojna") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => YojnaPage()));
        } else if (title == "Crop Detection") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ImageDetectionPage()));
        } else if (title == "Market Connectivity") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NearnessOfMarketPage()));
        } else if (title == "Tutorial") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorialPage()),
          );
        }


      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300,
              blurRadius: 6,
              spreadRadius: 2)
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 10),
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}