import 'package:flutter/material.dart';

class FlashcardsInstrumentsPage extends StatelessWidget {
  const FlashcardsInstrumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BABY CHIME',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'BikePark', // Assuming you have this font in your project
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset('assets/guitar_image.png'), // Replace with your image path
                    const Text('GUITAR', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    // Add more widgets here for the letter and sound icons
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}