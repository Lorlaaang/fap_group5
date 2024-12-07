import 'package:fap_group5/flashcards/flashcards_instruments.dart';
import 'package:fap_group5/flashcards/flashcards_shapes.dart';
import 'package:fap_group5/quiz/quiz_animals.dart';
import 'package:fap_group5/quiz/quiz_colors.dart';
import 'package:fap_group5/quiz/quiz_instruments.dart';
import 'package:fap_group5/quiz/quiz_shapes.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'flashcards/flashcards_animals.dart';
import 'quiz/quiz_colors.dart';
import 'flashcards/flashcards_colors.dart';
import 'fun_facts_page.dart'; // Import the Fun Facts Page

class HomePage extends StatelessWidget {
  final List<Category> categories = [
    Category(
      'Animals',
      'Meet your favorite animals friends!',
      'assets/images/animals.png',
      Colors.orange,
    ),
    Category(
      'Shapes',
      'Learn all about shapes!',
      'assets/images/shapes.png',
      Colors.green,
    ),
    Category(
      'Instruments',
      'Explore musical instruments!',
      'assets/images/instruments.png',
      Colors.pink,
    ),
    Category(
      'Colors',
      'Discover the world of colors!',
      'assets/images/colors.png',
      Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homepage_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              // Header with Back Button
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Colors.green,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'BABY CHIME',
                          style: TextStyle(
                            fontSize: 32, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'BikePark',
                          ),
                        ),
                      ),
                    ),
                    // Invisible icon button for symmetry
                    SizedBox(width: 48),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final Category category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        if (category.name == 'Animals') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FunFactsPage(), // Navigate to Fun Facts
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: category.color,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, // Allow image to overflow
                          children: [
                            // Category Info
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            category.name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            category.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                  ],
                                ),
                                SizedBox(height: 10),
                                // Buttons
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (category.name == 'Animals') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FlashcardsAnimalsPage(),
                                            ),
                                          );
                                        } else if (category.name == 'Instruments') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FlashcardsInstrumentsPage(),
                                            ),
                                          );
                                        } else if (category.name == 'Shapes') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FlashcardsShapesPage(),
                                            ),
                                          );
                                        } else if (category.name == 'Colors') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FlashcardsColorsPage(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 10,
                                        ),
                                      ),
                                      child: Text(
                                        'Learn',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    OutlinedButton(
                                      onPressed: () {
                                        if (category.name == 'Animals') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizAnimalsPage(),
                                            ),
                                          );
                                        } else if (category.name ==
                                            'Instruments') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizInstrumentsPage(),
                                            ),
                                          );
                                        } else if (category.name == 'Shapes') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizShapesPage(),
                                            ),
                                          );
                                        } else if (category.name == 'Colors') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizColorsPage(),
                                            ),
                                          );
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.white, width: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 10,
                                        ),
                                      ),
                                      child: Text(
                                        'Quiz',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Category Image
                            Positioned(
                              right: 0,
                              top: -10, // Adjusted from -15 to -10 to prevent cutoff
                              child: Image.asset(
                                category.image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
