import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import '../flashcards/flashcards_instruments.dart';
import '../home_page.dart';

class QuizInstrumentsPage extends StatefulWidget {
  const QuizInstrumentsPage({super.key});

  @override
  State<QuizInstrumentsPage> createState() => _QuizInstrumentsPageState();
}

class _QuizInstrumentsPageState extends State<QuizInstrumentsPage> {
  static const int TOTAL_QUESTIONS = 8;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentQuestionIndex = 0;
  List<Icon> scoreKeeper = [];
  List<Color> cardColors = List.generate(4, (index) => Colors.white);
  bool canAnswer = true; // Prevent multiple answers
  int correctAnswers = 0;

  final List<Map<String, String>> _instruments = [
    {
      'name': 'Guitar',
      'image': 'assets/images/instruments/guitar_image.png',
      'sound': 'assets/audio/instruments/guitar.mp3',
      'spelling': 'assets/audio/instruments/guitar_spelling.mp3'
    },
    {
      'name': 'Piano',
      'image': 'assets/images/instruments/piano_image.png',
      'sound': 'assets/audio/instruments/piano.mp3',
      'spelling': 'assets/audio/instruments/piano_spelling.mp3'
    },
    {
      'name': 'Drum',
      'image': 'assets/images/instruments/drum_image.png',
      'sound': 'assets/audio/instruments/drum.mp3',
      'spelling': 'assets/audio/instruments/drum_spelling.mp3'
    },
    {
      'name': 'Violin',
      'image': 'assets/images/instruments/violin_image.png',
      'sound': 'assets/audio/instruments/violin.mp3',
      'spelling': 'assets/audio/instruments/violin_spelling.mp3'
    },
    {
      'name': 'Flute',
      'image': 'assets/images/instruments/flute_image.png',
      'sound': 'assets/audio/instruments/flute.mp3',
      'spelling': 'assets/audio/instruments/flute_spelling.mp3'
    },
    {
      'name': 'Trumpet',
      'image': 'assets/images/instruments/trumpet_image.png',
      'sound': 'assets/audio/instruments/trumpet.mp3',
      'spelling': 'assets/audio/instruments/trumpet_spelling.mp3'
    },
    {
      'name': 'Kalimba',
      'image': 'assets/images/instruments/kalimba_image.png',
      'sound': 'assets/audio/instruments/kalimba.mp3',
      'spelling': 'assets/audio/instruments/kalimba_spelling.mp3'
    },
    {
      'name': 'Harp',
      'image': 'assets/images/instruments/harp_image.png',
      'sound': 'assets/audio/instruments/harp.mp3',
      'spelling': 'assets/audio/instruments/harp_spelling.mp3'
    },
    {
      'name': 'Maracas',
      'image': 'assets/images/instruments/maracas_image.png',
      'sound': 'assets/audio/instruments/maracas.mp3',
      'spelling': 'assets/audio/instruments/maracas_spelling.mp3'
    },
    {
      'name': 'Xylophone',
      'image': 'assets/images/instruments/xylophone_image.png',
      'sound': 'assets/audio/instruments/xylophone.mp3',
      'spelling': 'assets/audio/instruments/xylophone_spelling.mp3'
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
    // Generate random question from full instrument list
    List<Map<String, String>> availableInstruments = List.from(_instruments);
    Random random = Random();

    // Select random correct answer
    int randomIndex = random.nextInt(availableInstruments.length);
    currentQuestion = availableInstruments[randomIndex];
    availableInstruments.removeAt(randomIndex);

    // Generate 3 random wrong options
    availableInstruments.shuffle();
    var wrongOptions = availableInstruments.take(3).toList();

    // Combine and shuffle all options
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
              child: Text('Review Instruments'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashcardsInstrumentsPage(),
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
          // Background Image
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
              // Header with Back Button
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
                    children: [
                      // Question Section
                      // Update the Question Section in quiz_instruments.dart:
                      Container(
                        child: Text(
                          'SELECT THE CORRECT IMAGE',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepPurple,
                            fontFamily: 'Poppins',
                          ),
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
                              onPressed: () {
                                _playQuestionSound();
                              },
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
                      // Grid of Options
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
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
                      // Score Keeper
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
