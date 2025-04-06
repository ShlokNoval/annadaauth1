import 'package:flutter/material.dart';

class FertilizerCalculatorPage extends StatefulWidget {
  const FertilizerCalculatorPage({super.key});

  @override
  _FertilizerCalculatorPageState createState() => _FertilizerCalculatorPageState();
}

class _FertilizerCalculatorPageState extends State<FertilizerCalculatorPage> {
  String unit = "Acre"; // Default unit selection
  String? selectedCrop, selectedSoil, selectedGrowthStage;

  final TextEditingController areaController = TextEditingController();
  double nitrogen = 0, phosphorus = 0, potassium = 0;
  String recommendedFertilizer = "";

  // Expanded lists with more types
  final List<String> crops = [
    "Wheat", "Rice", "Corn", "Soybean", "Tomato", "Potato",
    "Carrot", "Onion", "Cabbage", "Chili", "Banana", "Apple"
  ];

  final List<String> soils = [
    "Sandy", "Clay", "Loam", "Silty", "Peaty",
    "Chalky", "Saline", "Red Soil", "Black Soil"
  ];

  final List<String> growthStages = [
    "Seedling", "Vegetative", "Flowering", "Fruiting",
    "Maturity", "Harvesting"
  ];

  void calculateFertilizer() {
    double area = double.tryParse(areaController.text) ?? 0;
    if (unit == "Hectare") area *= 2.471; // Convert hectare to acre

    nitrogen = area * 50;
    phosphorus = area * 30;
    potassium = area * 40;

    recommendFertilizer();
    setState(() {});
  }

  void recommendFertilizer() {
    recommendedFertilizer = "";

    if (nitrogen >= 100) {
      recommendedFertilizer += "🟢 **Urea (46% N):** ${((nitrogen / 46) * 100).toStringAsFixed(2)} kg\n";
    }
    if (phosphorus >= 50) {
      recommendedFertilizer += "🔵 **DAP (46% P):** ${((phosphorus / 46) * 100).toStringAsFixed(2)} kg\n";
    }
    if (potassium >= 40) {
      recommendedFertilizer += "🟠 **MOP (60% K):** ${((potassium / 60) * 100).toStringAsFixed(2)} kg\n";
    }

    if (recommendedFertilizer.isEmpty) {
      recommendedFertilizer = "✅ No additional fertilizer needed.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fertilizer Calculator", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.yellow.shade100], // Farming theme gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCard(
                title: "Land Area",
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: areaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Enter Area", border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: unit,
                      items: ["Acre", "Hectare"].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                      onChanged: (newValue) => setState(() => unit = newValue!),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              _buildCard(
                title: "Select Crop & Soil",
                child: Column(
                  children: [
                    _buildDropdown("Select Crop", crops, (value) => selectedCrop = value),
                    SizedBox(height: 10),
                    _buildDropdown("Select Soil Type", soils, (value) => selectedSoil = value),
                    SizedBox(height: 10),
                    _buildDropdown("Growth Stage", growthStages, (value) => selectedGrowthStage = value),
                  ],
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                onPressed: calculateFertilizer,
                child: Text("Calculate Fertilizer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),

              SizedBox(height: 20),

              if (nitrogen > 0) ...[
                _buildCard(
                  title: "Fertilizer Requirements",
                  bgColor: Colors.green.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🌱 **Crop Type:** $selectedCrop"),
                      Text("🌍 **Soil Type:** $selectedSoil"),
                      Text("📈 **Growth Stage:** $selectedGrowthStage"),
                      Divider(thickness: 1, color: Colors.green),
                      Text("💧 **Nitrogen Needed:** ${nitrogen.toStringAsFixed(2)} kg"),
                      Text("🌿 **Phosphorus Needed:** ${phosphorus.toStringAsFixed(2)} kg"),
                      Text("🟤 **Potassium Needed:** ${potassium.toStringAsFixed(2)} kg"),
                      Divider(thickness: 1, color: Colors.green),
                      Text("🛒 **Recommended Fertilizers:**", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(recommendedFertilizer, style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child, Color? bgColor}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: bgColor ?? Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: (value) => setState(() => onChanged(value)),
    );
  }
}
