import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allTutorials = [];
  List<Map<String, dynamic>> filteredTutorials = [];

  @override
  void initState() {
    super.initState();
    allTutorials = [
      {
        "title": "🌱 Introduction to Organic Farming",
        "type": "text",
        "content":
        "Organic farming relies on natural inputs like compost, green manure, and crop rotation. It avoids synthetic chemicals and genetically modified organisms (GMOs).\n\nAdvantages include improved soil health, reduced pollution, and better crop quality. Farmers can also gain premium prices for organic products."
      },
      {
        "title": "🚜 Basic Tractor Maintenance",
        "type": "text",
        "content":
        "1. Regularly check oil levels and change every 100-150 hours.\n2. Inspect tire pressure weekly.\n3. Clean air filters to improve fuel efficiency.\n4. Grease joints to prevent mechanical wear.\n5. Always store tractors in a covered area to avoid rust."
      },
      {
        "title": "🌾 How to Cultivate Wheat (Beginner's Guide)",
        "type": "video",
        "url": "https://www.youtube.com/watch?v=MyfHCt7DDOg"
      },
      {
        "title": "🧑‍🌾 Pest Control: Natural Remedies",
        "type": "text",
        "content":
        "• Neem oil spray is effective against most insects.\n• Garlic-chili spray keeps pests away from leafy crops.\n• Companion planting (e.g., basil near tomatoes) deters harmful bugs."
      },
      {
        "title": "💧 Drip vs. Sprinkler Irrigation",
        "type": "image",
        "imageUrl":
        "https://www.researchgate.net/publication/338053803/figure/fig1/AS:835245607219200@1575294216262/Drip-irrigation-vs-sprinkler-irrigation.png"
      },
      {
        "title": "🍅 Tomato Plant Pruning Techniques",
        "type": "video",
        "url": "https://www.youtube.com/watch?v=R65zFZ9-nPU"
      },
      {
        "title": "🌿 Vermicomposting Step-by-Step",
        "type": "text",
        "content":
        "1. Choose a bin and place it in a shady area.\n2. Add bedding (shredded paper, coconut coir).\n3. Add red wigglers (Eisenia fetida worms).\n4. Feed with veggie scraps, coffee grounds, crushed eggshells.\n5. Harvest compost after 2-3 months."
      },
      {
        "title": "🌻 Pest Identification Chart",
        "type": "image",
        "imageUrl":
        "https://cdn.agroop.net/wp-content/uploads/2020/09/insectos-agricultura.jpg"
      },
      {
        "title": "📉 How to Reduce Water Wastage in Agriculture",
        "type": "text",
        "content":
        "• Use drip irrigation instead of flooding.\n• Mulch your fields to reduce evaporation.\n• Grow drought-resistant crops.\n• Schedule irrigation based on real-time weather data.\n• Collect and reuse rainwater."
      },
      {
        "title": "📽️ Understanding Crop Rotation with Real Examples",
        "type": "video",
        "url": "https://www.youtube.com/watch?v=VcnzXJZxajQ"
      },
      {
        "title": "🌱 Fertilizer Schedule for Maize",
        "type": "text",
        "content":
        "• Basal dose: Apply NPK (10:26:26) at sowing time.\n• Top Dressing 1: Urea after 30 days.\n• Top Dressing 2: Urea + Potash at flowering stage.\n• Use Zinc Sulphate to prevent yellowing of leaves."
      },
      {
        "title": "📷 Soil Types & Textures (Visual Guide)",
        "type": "image",
        "imageUrl":
        "https://www.soils4teachers.org/files/s4t/images/SoilTexturesChart.jpg"
      },
    ];

    filteredTutorials = allTutorials;
  }

  void _searchTutorials(String query) {
    final results = allTutorials.where((tutorial) {
      final title = tutorial["title"].toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredTutorials = results;
    });
  }

  Widget _buildTutorialCard(Map<String, dynamic> tutorial) {
    switch (tutorial["type"]) {
      case "text":
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tutorial["title"],
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(tutorial["content"],
                    style: const TextStyle(fontSize: 15, height: 1.5)),
              ],
            ),
          ),
        );

      case "video":
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.lightGreen.shade100,
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.video_library, size: 40, color: Colors.red),
            title: Text(tutorial["title"],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Tap to watch video"),
            onTap: () => _launchURL(tutorial["url"]),
          ),
        );

      case "image":
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(tutorial["imageUrl"],
                      height: 200, width: double.infinity, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(tutorial["title"],
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text("Farming Tutorials"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextField(
            controller: searchController,
            onChanged: _searchTutorials,
            decoration: InputDecoration(
              hintText: "Search tutorials...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTutorials.length,
              itemBuilder: (context, index) {
                return _buildTutorialCard(filteredTutorials[index]);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
