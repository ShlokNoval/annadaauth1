import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YojnaPage extends StatelessWidget {
  final List<Map<String, String>> schemes = [
    {
      "name": "Pradhan Mantri Kisan Samman Nidhi (PM-KISAN)",
      "description": "Provides ₹6,000 per year in three installments to small and marginal farmers to support their financial needs.",
      "url": "https://pmkisan.gov.in/",
      "logo": "assets/pm-kisan.png",
    },
    {
      "name": "Pradhan Mantri Fasal Bima Yojana (PMFBY)",
      "description": "Offers crop insurance to protect farmers against crop losses due to natural disasters, pests, and diseases.",
      "url": "https://pmfby.gov.in/",
      "logo": "assets/pmfby.png",
    },
    {
      "name": "Kisan Credit Card (KCC) Scheme",
      "description": "Provides short-term credit to farmers at low-interest rates to help them with agricultural expenses.",
      "url": "https://www.pmkisan.gov.in/",
      "logo": "assets/kcc.png",
    },
    {
      "name": "Soil Health Card Scheme",
      "description": "Offers free soil testing services to farmers to determine the nutrient content and health of their soil.",
      "url": "https://soilhealth.dac.gov.in/",
      "logo": "assets/soil-health.png",
    },
    {
      "name": "PM Krishi Sinchayee Yojana (PMKSY)",
      "description": "Aims to provide water access for irrigation through better water conservation and management techniques.",
      "url": "https://pmksy.gov.in/",
      "logo": "assets/pmsky.png",
    },
    {
      "name": "e-NAM (National Agriculture Market)",
      "description": "A digital platform that helps farmers sell their produce directly to buyers across India at competitive prices.",
      "url": "https://enam.gov.in/",
      "logo": "assets/enam.png",
    },
    {
      "name": "Rashtriya Krishi Vikas Yojana (RKVY)",
      "description": "Provides financial aid to farmers for various agricultural projects, including infrastructure and market development.",
      "url": "https://rkvy.nic.in/",
      "logo": "assets/rkvy.png",
    },
    {
      "name": "Paramparagat Krishi Vikas Yojana (PKVY)",
      "description": "Encourages organic farming by providing training, financial assistance, and market access for organic produce.",
      "url": "https://pgsindia-ncof.gov.in/",
      "logo": "assets/pkvy.png",
    },
    {
      "name": "Dairy Entrepreneurship Development Scheme (DEDS)",
      "description": "Provides subsidies and financial support for setting up dairy farms, milk production, and processing units.",
      "url": "https://nabard.org/",
      "logo": "assets/deds.png",
    },
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Government Schemes"),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          schemes[index]['logo']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          schemes[index]['name']!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    schemes[index]['description']!,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(schemes[index]['url']!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: Icon(Icons.open_in_new, color: Colors.white, size: 18),
                      label: Text("Apply Now", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
