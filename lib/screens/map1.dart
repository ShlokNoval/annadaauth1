import 'package:flutter/material.dart';

class Map1Page extends StatefulWidget {
  const Map1Page({super.key});

  @override
  State<Map1Page> createState() => _Map1PageState();
}

class _Map1PageState extends State<Map1Page> {
  bool _imageClicked = false;

  void _onImageTap() {
    setState(() {
      _imageClicked = true;
    });
  }

  // Sample fertilizer shop data
  final List<Map<String, String>> _fertilizerShops = [
    {"name": "Green Grow Fertilizers", "location": "Mumbai, India", "distance": "2.3 km"},
    {"name": "AgriBoost Supplies", "location": "Pune, India", "distance": "3.8 km"},
    {"name": "FarmTech Fertilizers", "location": "Nagpur, India", "distance": "5.1 km"},
    {"name": "Harvest Pro Store", "location": "Nashik, India", "distance": "4.7 km"},
    {"name": "SoilCare Solutions", "location": "Aurangabad, India", "distance": "6.2 km"},
    {"name": "Organic Growth Hub", "location": "Ahmedabad, India", "distance": "7.5 km"},
    {"name": "FertiMax Wholesale", "location": "Indore, India", "distance": "8.0 km"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertilizer Shops Map"),
        backgroundColor: Colors.green.shade700,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search locations...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),

            const SizedBox(height: 16),

            // Display Image
            GestureDetector(
              onTap: _onImageTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.asset(
                    _imageClicked
                        ? "assets/new_location_image.png"
                        : "assets/map_fertilizer_shops.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Buttons (Appear only after image is clicked)
            if (_imageClicked)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions_walk),
                    label: const Text("Start"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions),
                    label: const Text("Directions"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 16),

            // Fertilizer Shops List (Scrollable)
            Expanded(
              child: ListView.builder(
                itemCount: _fertilizerShops.length,
                itemBuilder: (context, index) {
                  final shop = _fertilizerShops[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.store, color: Colors.green, size: 32),
                      title: Text(
                        shop["name"]!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${shop["location"]} • ${shop["distance"]}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.green),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}