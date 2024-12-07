import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FunFactsPage extends StatefulWidget {
  @override
  _FunFactsPageState createState() => _FunFactsPageState();
}

class _FunFactsPageState extends State<FunFactsPage> {
  String searchQuery = "";
  Map<String, dynamic>? animalData;
  bool isLoading = false;
  bool hasError = false;
  List<String> funFacts = [];
  int currentFactIndex = 0;

  Future<void> fetchAnimalData(String animalName) async {
    setState(() {
      isLoading = true;
      hasError = false;
      funFacts.clear();
    });

    const String apiKey = "MaJdwnoHbxd3sUm6CQaNCQ==KRpofNX3LGEdJsGZ";
    final String apiUrl = "https://api.api-ninjas.com/v1/animals?name=$animalName";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {"X-Api-Key": apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          // Extract multiple facts from characteristics
          Map<String, dynamic> characteristics = data[0]['characteristics'] ?? {};
          funFacts = characteristics.entries
              .where((entry) => entry.value != null && entry.value.toString().isNotEmpty)
              .map((entry) => "${entry.key.toString().replaceAll('_', ' ').capitalize()}: ${entry.value}")
              .toList();

          setState(() {
            animalData = data[0];
            currentFactIndex = 0;
            isLoading = false;
          });
        } else {
          setState(() {
            hasError = true;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  void showNextFact() {
    if (funFacts.isNotEmpty) {
      setState(() {
        currentFactIndex = (currentFactIndex + 1) % funFacts.length;
      });
    }
  }

  Widget buildAnimalCard(Map<String, dynamic> data) {
    final taxonomy = data['taxonomy'] ?? {};

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  data['name'] ?? "Unknown Animal",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Taxonomy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildTaxonomyItem("Kingdom", taxonomy['kingdom']),
                    buildTaxonomyItem("Class", taxonomy['class']),
                    buildTaxonomyItem("Family", taxonomy['family']),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Habitat",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      (data['locations'] as List?)?.join(', ') ?? 'Location unknown',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (funFacts.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Fun Fact #${currentFactIndex + 1}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        funFacts[currentFactIndex],
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: showNextFact,
                    icon: Icon(Icons.auto_awesome),
                    label: Text("Next Fun Fact"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaxonomyItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            value ?? 'N/A',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Animal Fun Facts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search for an Animal",
                  hintText: "Type an animal name...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  searchQuery = value;
                },
                onSubmitted: (value) {
                  fetchAnimalData(value);
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              )
                  : animalData != null
                  ? SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20),
                child: buildAnimalCard(animalData!),
              )
                  : hasError
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "No data found or an error occurred.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
                  : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 48,
                      color: Colors.orange,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Search for an animal to see fun facts!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}