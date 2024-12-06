import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FlashcardsInstrumentsPage extends StatefulWidget {
  @override
  _FlashcardsInstrumentsPageState createState() => _FlashcardsInstrumentsPageState();
}

class _FlashcardsInstrumentsPageState extends State<FlashcardsInstrumentsPage> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
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
      'name': 'Saxophone',
      'image': 'assets/images/instruments/saxophone_image.png',
      'sound': 'assets/audio/instruments/saxophone.mp3',
      'spelling': 'assets/audio/instruments/saxophone_spelling.mp3'
    },
    {
      'name': 'Harp',
      'image': 'assets/images/instruments/harp_image.png',
      'sound': 'assets/audio/instruments/harp.mp3',
      'spelling': 'assets/audio/instruments/harp_spelling.mp3'
    },
    {
      'name': 'Cello',
      'image': 'assets/images/instruments/cello_image.png',
      'sound': 'assets/audio/instruments/cello.mp3',
      'spelling': 'assets/audio/instruments/cello_spelling.mp3'
    },
    {
      'name': 'Clarinet',
      'image': 'assets/images/instruments/clarinet_image.png',
      'sound': 'assets/audio/instruments/clarinet.mp3',
      'spelling': 'assets/audio/instruments/clarinet_spelling.mp3'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Remove the previous method that doesn't exist
  }

  void _playSound(String soundPath) async {
    try {
      // Stop any currently playing audio
      await _audioPlayer.stop();

      // Play the audio using AssetSource
      Source source = AssetSource(soundPath.replaceFirst('assets/', ''));
      await _audioPlayer.play(source);

      print('Successfully played sound: $soundPath');
    } catch (e) {
      print('Error playing sound: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing audio: $e')),
      );
    }
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _instruments.length;
    });
    // Optional: Automatically play sound when moving to next card
    _playSound(_instruments[_currentIndex]['sound']!);
  }

  void _previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _instruments.length) % _instruments.length;
    });
    // Optional: Automatically play sound when moving to previous card
    _playSound(_instruments[_currentIndex]['sound']!);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final instrument = _instruments[_currentIndex];
    final blueColor = Colors.lightBlue; // Adjust this color to match the desired blue

    return Scaffold(
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
                                      Image.asset(instrument['image']!), // Replace with your image path
                                      const SizedBox(height: 10),
                                      Text(
                                        instrument['name']!,
                                        style: TextStyle(
                                          fontSize: 48, // Increased font size
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BikePark',
                                          color: blueColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.spellcheck, color: blueColor),
                                            onPressed: () {
                                              _playSound(instrument['spelling']!);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.volume_up, color: blueColor),
                                            onPressed: () {
                                              _playSound(instrument['sound']!);
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
                            icon: Icon(Icons.arrow_back, color: blueColor, size: 42),
                            onPressed: _previousCard,
                          ),
                          Text(
                            '${_currentIndex + 1} / ${_instruments.length}',
                            style: TextStyle(
                              fontSize: 42, // Increased font size
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BikePark',
                              color: blueColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward, color: blueColor, size: 42),
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