import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../home_page.dart';
import '../quiz/quiz_instruments.dart';
import '../models/instrument.dart';

class FlashcardsInstrumentsPage extends StatefulWidget {
  const FlashcardsInstrumentsPage({super.key});

  @override
  _FlashcardsInstrumentsPageState createState() =>
      _FlashcardsInstrumentsPageState();
}

class _FlashcardsInstrumentsPageState extends State<FlashcardsInstrumentsPage> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Instrument> _instruments = [
    // String Instruments
    StringInstrument(
        'Guitar',
        'assets/images/instruments/guitar_image.png',
        'assets/audio/instruments/guitar.mp3',
        'assets/audio/instruments/guitar_spelling.mp3'),
    StringInstrument(
        'Piano',
        'assets/images/instruments/piano_image.png',
        'assets/audio/instruments/piano.mp3',
        'assets/audio/instruments/piano_spelling.mp3'),
    StringInstrument(
        'Violin',
        'assets/images/instruments/violin_image.png',
        'assets/audio/instruments/violin.mp3',
        'assets/audio/instruments/violin_spelling.mp3'),
    StringInstrument(
        'Harp',
        'assets/images/instruments/harp_image.png',
        'assets/audio/instruments/harp.mp3',
        'assets/audio/instruments/harp_spelling.mp3'),

    // Wind Instruments
    WindInstrument(
        'Flute',
        'assets/images/instruments/flute_image.png',
        'assets/audio/instruments/flute.mp3',
        'assets/audio/instruments/flute_spelling.mp3'),
    WindInstrument(
        'Trumpet',
        'assets/images/instruments/trumpet_image.png',
        'assets/audio/instruments/trumpet.mp3',
        'assets/audio/instruments/trumpet_spelling.mp3'),

    // Percussion Instruments
    PercussionInstrument(
        'Drum',
        'assets/images/instruments/drum_image.png',
        'assets/audio/instruments/drum.mp3',
        'assets/audio/instruments/drum_spelling.mp3'),
    PercussionInstrument(
        'Kalimba',
        'assets/images/instruments/kalimba_image.png',
        'assets/audio/instruments/kalimba.mp3',
        'assets/audio/instruments/kalimba_spelling.mp3'),
    PercussionInstrument(
        'Maracas',
        'assets/images/instruments/maracas_image.png',
        'assets/audio/instruments/maracas.mp3',
        'assets/audio/instruments/maracas_spelling.mp3'),
    PercussionInstrument(
        'Xylophone',
        'assets/images/instruments/xylophone_image.png',
        'assets/audio/instruments/xylophone.mp3',
        'assets/audio/instruments/xylophone_spelling.mp3'),
  ];

// Update initState
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playInstrumentSound(_instruments[_currentIndex]);
    });
  }

  // Add this method to the _FlashcardsInstrumentsPageState class
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
                      builder: (context) => const QuizInstrumentsPage()),
                      (route) => false,
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
    if (_currentIndex == _instruments.length - 1) {
      _showCompletionDialog();
      return;
    }

    setState(() {
      _currentIndex = (_currentIndex + 1) % _instruments.length;
    });
    _playInstrumentSound(_instruments[_currentIndex]);
  }

// Update _previousCard
  void _previousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _instruments.length) % _instruments.length;
    });
    _playInstrumentSound(_instruments[_currentIndex]);
  }

  void _playInstrumentSound(Instrument instrument) async {
    try {
      await instrument.playSound(_audioPlayer);
    } catch (e) {
      print('Error type: ${e.runtimeType}');
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to play audio'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

// Add this method to _FlashcardsInstrumentsPageState
  void _playSpellingSound(Instrument instrument) async {
    try {
      await instrument.playSpelling(_audioPlayer);
    } catch (e) {
      print('Error type: ${e.runtimeType}');
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to play audio'),
          duration: Duration(seconds: 2),
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
    final instrument = _instruments[_currentIndex];
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
                                      Image.asset(instrument.imagePath),
                                      const SizedBox(height: 10),
                                      Text(
                                        instrument.name,
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
                                              _playSpellingSound(instrument);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.volume_up,
                                                color: blueColor),
                                            onPressed: () {
                                              _playInstrumentSound(instrument);
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
                            '${_currentIndex + 1} / ${_instruments.length}',
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
