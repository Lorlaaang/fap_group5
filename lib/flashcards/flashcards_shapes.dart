import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../home_page.dart';
import '../quiz/quiz_shapes.dart';
import '../models/shape.dart';

class FlashcardsShapesPage extends StatefulWidget {
  const FlashcardsShapesPage({super.key});

  @override
  _FlashcardsShapesPageState createState() => _FlashcardsShapesPageState();
}

class _FlashcardsShapesPageState extends State<FlashcardsShapesPage> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Shape> _shapes = [
    // 2D Shapes
    TwoDimensionalShape(
        'Circle',
        'assets/images/shapes/circle_image.png',
        'assets/audio/shapes/circle_description.mp3',
        'assets/audio/shapes/circle_spelling.mp3'),
    TwoDimensionalShape(
        'Square',
        'assets/images/shapes/square_image.png',
        'assets/audio/shapes/square_description.mp3',
        'assets/audio/shapes/square_spelling.mp3'),
    TwoDimensionalShape(
        'Triangle',
        'assets/images/shapes/triangle_image.png',
        'assets/audio/shapes/triangle_description.mp3',
        'assets/audio/shapes/triangle_spelling.mp3'),
    TwoDimensionalShape(
        'Diamond',
        'assets/images/shapes/diamond_image.png',
        'assets/audio/shapes/diamond_description.mp3',
        'assets/audio/shapes/diamond_spelling.mp3'),
    TwoDimensionalShape(
        'Pentagon',
        'assets/images/shapes/pentagon_image.png',
        'assets/audio/shapes/pentagon_description.mp3',
        'assets/audio/shapes/pentagon_spelling.mp3'),
    TwoDimensionalShape(
        'Parallelogram',
        'assets/images/shapes/parallelogram_image.png',
        'assets/audio/shapes/parallelogram_description.mp3',
        'assets/audio/shapes/parallelogram_spelling.mp3'),
    TwoDimensionalShape(
        'Hexagon',
        'assets/images/shapes/hexagon_image.png',
        'assets/audio/shapes/hexagon_description.mp3',
        'assets/audio/shapes/hexagon_spelling.mp3'),
    TwoDimensionalShape(
        'Heptagon',
        'assets/images/shapes/heptagon_image.png',
        'assets/audio/shapes/heptagon_description.mp3',
        'assets/audio/shapes/heptagon_spelling.mp3'),
    TwoDimensionalShape(
        'Octagon',
        'assets/images/shapes/octagon_image.png',
        'assets/audio/shapes/octagon_description.mp3',
        'assets/audio/shapes/octagon_spelling.mp3'),
    TwoDimensionalShape(
        'Heart',
        'assets/images/shapes/heart_image.png',
        'assets/audio/shapes/heart_description.mp3',
        'assets/audio/shapes/heart_spelling.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playShapeDescription(_shapes[_currentIndex]);
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('Congratulations on learning all the shapes!'),
          actions: [
            TextButton(
              child: const Text('Go to Home'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                );
              },
            ),
            TextButton(
              child: const Text('Go to Quiz'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuizShapesPage()),
                      (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _nextCard() {
    if (_currentIndex == _shapes.length - 1) {
      _showCompletionDialog();
      return;
    }

    setState(() {
      _currentIndex = (_currentIndex + 1) % _shapes.length;
    });
    _playShapeDescription(_shapes[_currentIndex]);
  }

  void _previousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _shapes.length) % _shapes.length;
    });
    _playShapeDescription(_shapes[_currentIndex]);
  }

  void _playShapeDescription(Shape shape) async {
    try {
      await shape.playDescription(_audioPlayer);
    } catch (e) {
      print('Error type: ${e.runtimeType}');
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to play audio'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _playSpellingSound(Shape shape) async {
    try {
      await shape.playSpelling(_audioPlayer);
    } catch (e) {
      print('Error type: ${e.runtimeType}');
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to play audio'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shape = _shapes[_currentIndex];
    const blueColor =
        Colors.lightBlue; // Adjust this color to match the desired blue

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no_clouds_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              // Header with Back Button
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.green,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'BABY CHIME',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'BikePark',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: blueColor, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset(shape.imagePath),
                                      const SizedBox(height: 10),
                                      Text(
                                        shape.name,
                                        style: const TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BikePark',
                                          color: blueColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.spellcheck,
                                                color: blueColor),
                                            onPressed: () {
                                              _playSpellingSound(shape);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.volume_up,
                                                color: blueColor),
                                            onPressed: () {
                                              _playShapeDescription(shape);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: blueColor, size: 42),
                            onPressed: _previousCard,
                          ),
                          Text(
                            '${_currentIndex + 1} / ${_shapes.length}',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BikePark',
                              color: blueColor,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward,
                                color: blueColor, size: 42),
                            onPressed: _nextCard,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
