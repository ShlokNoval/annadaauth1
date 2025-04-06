import 'package:flutter/material.dart';
import 'package:annadaauth1/screens/map1.dart'; // For Locate Fertilizers Shops
import 'package:annadaauth1/screens/map2.dart'; // For Search nearby Market
import 'package:annadaauth1/screens/map3.dart'; // For Local NGOs

class NearnessOfMarketPage extends StatefulWidget {
  const NearnessOfMarketPage({super.key});

  @override
  State<NearnessOfMarketPage> createState() => _NearnessOfMarketPageState();
}

class _NearnessOfMarketPageState extends State<NearnessOfMarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearness Of Market"),
        backgroundColor: Colors.green.shade700,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nearby Markets",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    MarketCard(
                      marketName: "Locate Fertilizers Shops",
                      onTap: () => _navigateToMap(context, const Map1Page()),
                    ),
                    MarketCard(
                      marketName: "Search nearby Market",
                      onTap: () => _navigateToMap(context, const Map2Page()),
                    ),
                    MarketCard(
                      marketName: "Local recycling agencies",
                      onTap: () => _navigateToMap(context, const Map3Page()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMap(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Slide in from right
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  }
}

class MarketCard extends StatelessWidget {
  final String marketName;
  final VoidCallback onTap;

  const MarketCard({
    super.key,
    required this.marketName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(
                Icons.store,
                size: 40,
                color: Colors.green,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      marketName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
