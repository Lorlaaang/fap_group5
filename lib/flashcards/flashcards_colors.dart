import 'package:fap_group5/flashcards/flashcard_item.dart';
import 'package:fap_group5/quiz/quiz_colors.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../home_page.dart';
import 'flashcard_item.dart';

class FlashcardsColorsPage extends StatefulWidget {
  const FlashcardsColorsPage({super.key});

  @override
  _FlashcardsColorsPageState createState() =>
      _FlashcardsColorsPageState();
}

class _FlashcardsColorsPageState extends State<FlashcardsColorsPage> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Flashcard_Item> _colors = [
    Flashcard_Item(
        'RED', 
        'assets/images/colors/red.png', 
        'audio/colors/red_audio.mp3', 
        'audio/colors/red_spelling.mp3'
    ),
    Flashcard_Item(
        'BLUE', 
        'assets/images/colors/blue.png', 
        'audio/colors/blue_audio.mp3', 
        'audio/colors/blue_spelling.mp3'
    ),
    Flashcard_Item(
        'YELLOW', 
        'assets/images/colors/yellow.png', 
        'audio/colors/yellow_audio.mp3', 
        'audio/colors/yellow_spelling.mp3'
    ),
    Flashcard_Item(
        'GREEN', 
        'assets/images/colors/green.png', 
        'audio/colors/green_audio.mp3', 
        'audio/colors/green_spelling.mp3'
    ),
    
    Flashcard_Item(
        'ORANGE', 
        'assets/images/colors/orange.png', 
        'audio/colors/orange_audio.mp3', 
        'audio/colors/orange_spelling.mp3'
    ),
    Flashcard_Item(
        'PURPLE', 
        'assets/images/colors/purple.png', 
        'audio/colors/purple_audio.mp3', 
        'audio/colors/purple_spelling.mp3'
    ),
    
    Flashcard_Item(
        'PINK', 
        'assets/images/colors/pink.png', 
        'audio/colors/pink_audio.mp3',
        'audio/colors/pink_spelling.mp3'
    ),
    Flashcard_Item(
        'BROWN', 
        'assets/images/colors/brown.png', 
        'audio/colors/brown_audio.mp3', 
        'audio/colors/brown_spelling.mp3'
    ),
    Flashcard_Item(
        'BLACK', 
        'assets/images/colors/black.png',
        'audio/colors/black_audio.mp3', 
        'audio/colors/black_spelling.mp3'
    ),
    Flashcard_Item(
        'GRAY', 
        'assets/images/colors/gray.png', 
        'audio/colors/gray_audio.mp3', 
        'audio/colors/gray_spelling.mp3'
    ),
  ];

  void playAudio(String audioPath) {
    final player = AudioPlayer();
    player.play(AssetSource(audioPath));
  }

// Update initState
  @override
  void initState() {
    super.initState();
  }

  // Add this method to the _FlashcardsColorsPageState class
  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content:
          const Text('Congratulations on learning all the instruments!'),
          actions: [
            TextButton(
              child: const Text('Go to Home'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Go to Quiz'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizColorsPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

// Update _nextCard
  void _nextCard() {
    if (_currentIndex == _colors.length - 1) {
      _showCompletionDialog();
      return;
    }

    setState(() {
      _currentIndex = (_currentIndex + 1) % _colors.length;
    });
    playAudio(_colors[_currentIndex].audioPath);
  }

// Update _previousCard
  void _previousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _colors.length) % _colors.length;
    });
    playAudio(_colors[_currentIndex].audioPath);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final instrument = _colors[_currentIndex];
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
                            fontSize: 32, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'BikePark',
                          ),
                        ),
                      ),
                    ),
                    // Invisible icon button for symmetry
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
                                  border:
                                  Border.all(color: blueColor, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: // Replace the build method UI part with:
                                  Column(
                                    children: [
                                      Image.asset(_colors[_currentIndex].imagePath),
                                      const SizedBox(height: 10),
                                      Text(
                                        _colors[_currentIndex].imageName,
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
                                              playAudio(_colors[_currentIndex].spellingPath);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.volume_up,
                                                color: blueColor),
                                            onPressed: () {
                                              playAudio(_colors[_currentIndex].audioPath);
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
                      const SizedBox(height: 10), // Adjusted spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: blueColor, size: 42),
                            onPressed: _previousCard,
                          ),
                          Text(
                            '${_currentIndex + 1} / ${_colors.length}',
                            style: const TextStyle(
                              fontSize: 42, // Increased font size
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
