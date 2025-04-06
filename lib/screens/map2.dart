import 'package:flutter/material.dart';

class Map2Page extends StatelessWidget {
  const Map2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Market Map"),
        backgroundColor: Colors.green.shade700,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              "assets/map_nearby_market.png", // Corrected path
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Market Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("View Locations"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Get Directions"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}