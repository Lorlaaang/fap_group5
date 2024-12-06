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
    {'name': 'Guitar', 'image': 'assets/guitar_image.png', 'sound': 'assets/audio/guitar.mp3', 'spelling': 'assets/audio/guitar_spelling.mp3'},
    {'name': 'Piano', 'image': 'assets/piano_image.png', 'sound': 'assets/audio/piano.mp3', 'spelling': 'assets/audio/piano_spelling.mp3'},
    {'name': 'Drum', 'image': 'assets/drum_image.png', 'sound': 'assets/audio/drum.mp3', 'spelling': 'assets/audio/drum_spelling.mp3'},
    {'name': 'Violin', 'image': 'assets/violin_image.png', 'sound': 'assets/audio/violin.mp3', 'spelling': 'assets/audio/violin_spelling.mp3'},
    {'name': 'Flute', 'image': 'assets/flute_image.png', 'sound': 'assets/audio/flute.mp3', 'spelling': 'assets/audio/flute_spelling.mp3'},
    {'name': 'Trumpet', 'image': 'assets/trumpet_image.png', 'sound': 'assets/audio/trumpet.mp3', 'spelling': 'assets/audio/trumpet_spelling.mp3'},
    {'name': 'Saxophone', 'image': 'assets/saxophone_image.png', 'sound': 'assets/audio/saxophone.mp3', 'spelling': 'assets/audio/saxophone_spelling.mp3'},
    {'name': 'Harp', 'image': 'assets/harp_image.png', 'sound': 'assets/audio/harp.mp3', 'spelling': 'assets/audio/harp_spelling.mp3'},
    {'name': 'Cello', 'image': 'assets/cello_image.png', 'sound': 'assets/audio/cello.mp3', 'spelling': 'assets/audio/cello_spelling.mp3'},
    {'name': 'Clarinet', 'image': 'assets/clarinet_image.png', 'sound': 'assets/audio/clarinet.mp3', 'spelling': 'assets/audio/clarinet_spelling.mp3'},
  ];

  @override
  void initState() {
    super.initState();
    _playSound(_instruments[_currentIndex]['sound']!);
  }

  void _playSound(String soundPath) async {
    await _audioPlayer.play(DeviceFileSource(soundPath));
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _instruments.length;
      _playSound(_instruments[_currentIndex]['sound']!);
    });
  }

  void _previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _instruments.length) % _instruments.length;
      _playSound(_instruments[_currentIndex]['sound']!);
    });
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