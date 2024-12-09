
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../home_page.dart';
import '../quiz/quiz_animals.dart';
import '../models/animal.dart';

class FlashcardsAnimalsPage extends StatefulWidget {
  const FlashcardsAnimalsPage({super.key});

  @override
  _FlashcardsAnimalsPageState createState() => _FlashcardsAnimalsPageState();
}

class _FlashcardsAnimalsPageState extends State<FlashcardsAnimalsPage> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Animal> _animals = [
    // Mammals
    Mammal(
        'Lion',
        'assets/images/animals/lion_image.png',
        'assets/audio/animals/lion.mp3',
        'assets/audio/animals/lion_spelling.mp3'),
    Mammal(
        'Elephant',
        'assets/images/animals/elephant_image.png',
        'assets/audio/animals/elephant.mp3',
        'assets/audio/animals/elephant_spelling.mp3'),
    Mammal(
        'Horse',
        'assets/images/animals/horse_image.png',
        'assets/audio/animals/horse.mp3',
        'assets/audio/animals/horse_spelling.mp3'),
    Mammal(
        'Goat',
        'assets/images/animals/goat_image.png',
        'assets/audio/animals/goat.mp3',
        'assets/audio/animals/goat_spelling.mp3'),

    // Birds
    Bird(
        'Parrot',
        'assets/images/animals/parrot_image.png',
        'assets/audio/animals/parrot.mp3',
        'assets/audio/animals/parrot_spelling.mp3'),
    Bird(
        'Eagle',
        'assets/images/animals/eagle_image.png',
        'assets/audio/animals/eagle.mp3',
        'assets/audio/animals/eagle_spelling.mp3'),

    // Reptiles
    Reptile(
        'Snake',
        'assets/images/animals/snake_image.png',
        'assets/audio/animals/snake.mp3',
        'assets/audio/animals/snake_spelling.mp3'),
    Reptile(
        'Crocodile',
        'assets/images/animals/crocodile_image.png',
        'assets/audio/animals/crocodile.mp3',
        'assets/audio/animals/crocodile_spelling.mp3'),
    Reptile(
        'Turtle',
        'assets/images/animals/turtle_image.png',
        'assets/audio/animals/turtle.mp3',
        'assets/audio/animals/turtle_spelling.mp3'),
    Reptile(
        'Lizard',
        'assets/images/animals/lizard_image.png',
        'assets/audio/animals/lizard.mp3',
        'assets/audio/animals/lizard_spelling.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAnimalSound(_animals[_currentIndex]);
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('Congratulations on learning all the animals!'),
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
                      builder: (context) => const QuizAnimalsPage()),
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
    if (_currentIndex == _animals.length - 1) {
      _showCompletionDialog();
      return;
    }

    setState(() {
      _currentIndex = (_currentIndex + 1) % _animals.length;
    });
    _playAnimalSound(_animals[_currentIndex]);
  }

  void _previousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _animals.length) % _animals.length;
    });
    _playAnimalSound(_animals[_currentIndex]);
  }

  void _playAnimalSound(Animal animal) async {
    try {
      await animal.playSound(_audioPlayer);
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

  void _playSpellingSound(Animal animal) async {
    try {
      await animal.playSpelling(_audioPlayer);
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
    final animal = _animals[_currentIndex];
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
                                      Image.asset(animal.imagePath),
                                      const SizedBox(height: 10),
                                      Text(
                                        animal.name,
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
                                              _playSpellingSound(animal);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.volume_up,
                                                color: blueColor),
                                            onPressed: () {
                                              _playAnimalSound(animal);
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
                            '${_currentIndex + 1} / ${_animals.length}',
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

