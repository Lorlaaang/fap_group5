import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import '../flashcards/flashcards_animals.dart';
import '../home_page.dart';

class QuizAnimalsPage extends StatefulWidget {
  const QuizAnimalsPage({super.key});

  @override
  State<QuizAnimalsPage> createState() => _QuizAnimalsPageState();
}

class _QuizAnimalsPageState extends State<QuizAnimalsPage> {
  static const int TOTAL_QUESTIONS = 8;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentQuestionIndex = 0;
  List<Icon> scoreKeeper = [];
  List<Color> cardColors = List.generate(4, (index) => Colors.white);
  bool canAnswer = true; // Prevent multiple answers
  int correctAnswers = 0;

  final List<Map<String, String>> _animals = [
    {
      'name': 'Crocodile',
      'image': 'assets/images/animals/crocodile_image.png',
      'sound': 'assets/audio/animals/crocodile.mp3',
    },
    {
      'name': 'Eagle',
      'image': 'assets/images/animals/eagle_image.png',
      'sound': 'assets/audio/animals/eagle.mp3',
    },
    {
      'name': 'Elephant',
      'image': 'assets/images/animals/elephant_image.png',
      'sound': 'assets/audio/animals/elephant.mp3',
    },
    {
      'name': 'Goat',
      'image': 'assets/images/animals/goat_image.png',
      'sound': 'assets/audio/animals/goat.mp3',
    },
    {
      'name': 'Horse',
      'image': 'assets/images/animals/horse_image.png',
      'sound': 'assets/audio/animals/horse.mp3',
    },
    {
      'name': 'Lion',
      'image': 'assets/images/animals/lion_image.png',
      'sound': 'assets/audio/animals/lion.mp3',
    },
    {
      'name': 'Lizard',
      'image': 'assets/images/animals/lizard_image.png',
      'sound': 'assets/audio/animals/lizard.mp3',
    },
    {
      'name': 'Parrot',
      'image': 'assets/images/animals/parrot_image.png',
      'sound': 'assets/audio/animals/parrot.mp3',
    },
    {
      'name': 'Snake',
      'image': 'assets/images/animals/snake_image.png',
      'sound': 'assets/audio/animals/snake.mp3',
    },
    {
      'name': 'Turtle',
      'image': 'assets/images/animals/turtle_image.png',
      'sound': 'assets/audio/animals/turtle.mp3',
    },
  ];

  late Map<String, String> currentQuestion;
  late List<Map<String, String>> currentOptions;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playQuestionSound();
    });
  }

  void _generateQuestion() {
    List<Map<String, String>> availableAnimals = List.from(_animals);
    Random random = Random();

    int randomIndex = random.nextInt(availableAnimals.length);
    currentQuestion = availableAnimals[randomIndex];
    availableAnimals.removeAt(randomIndex);

    availableAnimals.shuffle();
    var wrongOptions = availableAnimals.take(3).toList();

    currentOptions = [...wrongOptions, currentQuestion]..shuffle();
  }

  void _playQuestionSound() async {
    try {
      await _audioPlayer.stop();
      final assetPath = currentQuestion['sound']!.replaceAll('assets/', '');
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _checkAnswer(int selectedIndex) async {
    if (!canAnswer) return;
    canAnswer = false;

    bool isCorrect = currentOptions[selectedIndex] == currentQuestion;

    setState(() {
      cardColors[selectedIndex] =
      isCorrect ? Colors.green.shade100 : Colors.red.shade100;
      scoreKeeper.add(
        Icon(
          isCorrect ? Icons.check : Icons.close,
          color: isCorrect ? Colors.green : Colors.red,
        ),
      );
      if (isCorrect) correctAnswers++;
    });

    await Future.delayed(Duration(milliseconds: 500));

    if (_currentQuestionIndex < TOTAL_QUESTIONS - 1) {
      setState(() {
        _currentQuestionIndex++;
        cardColors = List.generate(4, (index) => Colors.white);
        _generateQuestion();
        canAnswer = true;
      });
      _playQuestionSound();
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Complete!'),
          content: Text(
            'You got $correctAnswers out of $TOTAL_QUESTIONS questions correct!',
            style: const TextStyle(fontSize: 18),
          ),
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
              child: const Text('Review Animals'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FlashcardsAnimalsPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no_clouds_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.green,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'SELECT THE CORRECT IMAGE',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
                                Icons.volume_up_outlined,
                                size: 30,
                              ),
                              onPressed: _playQuestionSound,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              currentQuestion['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _checkAnswer(index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cardColors[index],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                                child: Image.asset(
                                  currentOptions[index]['image']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: scoreKeeper,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
