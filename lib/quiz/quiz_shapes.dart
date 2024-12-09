import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import '../flashcards/flashcards_shapes.dart';
import '../home_page.dart';

class QuizShapesPage extends StatefulWidget {
  const QuizShapesPage({super.key});

  @override
  State<QuizShapesPage> createState() => _QuizShapesPageState();
}

class _QuizShapesPageState extends State<QuizShapesPage> {
  static const int TOTAL_QUESTIONS = 8;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentQuestionIndex = 0;
  List<Icon> scoreKeeper = [];
  List<Color> cardColors = List.generate(4, (index) => Colors.white);
  bool canAnswer = true;
  int correctAnswers = 0;

  final List<Map<String, String>> _shapes = [
    {
      'name': 'Circle',
      'image': 'assets/images/shapes/circle_image.png',
      'sound': 'assets/audio/shapes/circle_spelling.mp3',
    },
    {
      'name': 'Diamond',
      'image': 'assets/images/shapes/diamond_image.png',
      'sound': 'assets/audio/shapes/diamond_spelling.mp3',
    },
    {
      'name': 'Heart',
      'image': 'assets/images/shapes/heart_image.png',
      'sound': 'assets/audio/shapes/heart_spelling.mp3',
    },
    {
      'name': 'Heptagon',
      'image': 'assets/images/shapes/heptagon_image.png',
      'sound': 'assets/audio/shapes/heptagon_spelling.mp3',
    },
    {
      'name': 'Hexagon',
      'image': 'assets/images/shapes/hexagon_image.png',
      'sound': 'assets/audio/shapes/hexagon_spelling.mp3',
    },
    {
      'name': 'Octagon',
      'image': 'assets/images/shapes/octagon_image.png',
      'sound': 'assets/audio/shapes/octagon_spelling.mp3',
    },
    {
      'name': 'Parallelogram',
      'image': 'assets/images/shapes/parallelogram_image.png',
      'sound': 'assets/audio/shapes/parallelogram_spelling.mp3',
    },
    {
      'name': 'Pentagon',
      'image': 'assets/images/shapes/pentagon_image.png',
      'sound': 'assets/audio/shapes/pentagon_spelling.mp3',
    },
    {
      'name': 'Square',
      'image': 'assets/images/shapes/square_image.png',
      'sound': 'assets/audio/shapes/square_spelling.mp3',
    },
    {
      'name': 'Triangle',
      'image': 'assets/images/shapes/triangle_image.png',
      'sound': 'assets/audio/shapes/triangle_spelling.mp3',
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
    List<Map<String, String>> availableShapes = List.from(_shapes);
    Random random = Random();

    int randomIndex = random.nextInt(availableShapes.length);
    currentQuestion = availableShapes[randomIndex];
    availableShapes.removeAt(randomIndex);

    availableShapes.shuffle();
    var wrongOptions = availableShapes.take(3).toList();

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
    if (!canAnswer) return; // Prevent multiple answers
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

    await Future.delayed(Duration(milliseconds: 500)); // Delay to show feedback

    if (_currentQuestionIndex < TOTAL_QUESTIONS - 1) {
      setState(() {
        _currentQuestionIndex++;
        cardColors = List.generate(4, (index) => Colors.white); // Reset colors
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
          title: Text('Quiz Complete!'),
          content: Text(
            'You got $correctAnswers out of $TOTAL_QUESTIONS questions correct!',
            style: TextStyle(fontSize: 18),
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
              child: Text('Review Shapes'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashcardsShapesPage(),
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
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no_clouds_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Colors.green,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
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
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT THE CORRECT IMAGE',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins',
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
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
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: scoreKeeper,
                        ),
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

