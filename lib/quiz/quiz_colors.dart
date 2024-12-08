import 'package:audioplayers/audioplayers.dart';
import 'package:fap_group5/flashcards/flashcards_colors.dart';
import 'package:fap_group5/quiz/quiz_brain.dart';
import 'package:fap_group5/quiz/quiz_item.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../home_page.dart';

class QuizColorsPage extends StatelessWidget {
  const QuizColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'BABY CHIME',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'BikePark',
          ),
        ),
      ),
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
          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: QuizColors(), // Ensure QuizColors widget is implemented properly
            ),
          ),
        ],
      ),
    );
  }
}


class QuizColors extends StatefulWidget {
  const QuizColors({super.key});

  @override
  State<QuizColors> createState() => _QuizColorsState();
}

class _QuizColorsState extends State<QuizColors> {
  @override
  void initState() {
    super.initState();
    randomizedCards = quizBrain.getRandomizedItems(quizBank);
    for (int i = 0; i < randomizedCards.length; i++) {
      cardColors[i] = Colors.blue; // Initialize all cards with transparent color
    }
  }

  List<Icon> scoreKeeper = [];
  Quiz_Brain quizBrain = new Quiz_Brain();
  int score = 0;

  final List<Quiz_Item> quizBank = [
    Quiz_Item('RED', 'assets/images/colors/red.png', 'audio/colors/red_audio.mp3'),
    Quiz_Item('BLUE', 'assets/images/colors/blue.png', 'audio/colors/blue_audio.mp3'),
    Quiz_Item('YELLOW', 'assets/images/colors/yellow.png', 'audio/colors/yellow_audio.mp3'),
    Quiz_Item('GREEN', 'assets/images/colors/green.png', 'audio/colors/green_audio.mp3'),
    Quiz_Item('ORANGE', 'assets/images/colors/orange.png', 'audio/colors/orange_audio.mp3'),
    Quiz_Item('PURPLE', 'assets/images/colors/purple.png', 'audio/colors/purple_audio.mp3'),
    Quiz_Item('PINK', 'assets/images/colors/pink.png', 'audio/colors/pink_audio.mp3'),
    Quiz_Item('BROWN', 'assets/images/colors/brown.png', 'audio/colors/brown_audio.mp3'),
    Quiz_Item('BLACK', 'assets/images/colors/black.png', 'audio/colors/black_audio.mp3'),
    Quiz_Item('GRAY', 'assets/images/colors/gray.png', 'audio/colors/gray_audio.mp3'),
  ];

  List<Quiz_Item> randomizedCards = [];

  Map<int, Color> cardColors = {};

  void playAudio(String audioPath) {
    final player = AudioPlayer();
    player.play(AssetSource(audioPath));
  }

  bool checkAnswer(String selectedImageName) {
    if(selectedImageName == quizBrain.getCorrectImageName(quizBank)) {
      scoreKeeper.add(
        Icon(
          Icons.check,
          color: Colors.deepPurple
        )
      );
      score++;
      return true;
    } else {
      scoreKeeper.add(
        Icon(
          Icons.close,
          color: Colors.red
        ),
      );
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
                    String audioPath = quizBrain.getAudioPath(quizBank);
                    playAudio(audioPath);
                  },
                ),
                SizedBox(width: 8.0),
                Text(
                  quizBrain.getCorrectImageName(quizBank),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: GridView.builder(
              itemCount: randomizedCards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 1,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                Quiz_Item selectedCard = randomizedCards[index];
                String selectedImageName = selectedCard.imageName;

                setState(() {
                  bool isCorrect = checkAnswer(selectedImageName);

                  // Update only the clicked card's color
                  cardColors[index] = isCorrect ? Colors.green : Colors.red;

                  Future.delayed(Duration(milliseconds: 500), () {
                    setState(() {
                      if (!quizBrain.isFinished(quizBank)) {
                      quizBrain.nextQuestion(quizBank); // Increment the question
                      randomizedCards = quizBrain.getRandomizedItems(quizBank);

                      // Reset all cards to default blue border
                      for (int i = 0; i < randomizedCards.length; i++) {
                        cardColors[i] = Colors.blue;
                      }
                    } else {
                      // Handle quiz completion (show dialog, restart logic)
                      scoreKeeper = [];
                      quizBrain.restartQuiz();
                      randomizedCards = quizBrain.getRandomizedItems(quizBank);
                      // Show the alert
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Finished'),
                            content: Text('You scored $score / 10.'),
                            actions: [
                              TextButton(
                                child: Text('Home Page'),
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
                                child: Text('Review Colors'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FlashcardsColorsPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                });
              });
            },
                child: cardContainer(
                  randomizedCards[index].imagePath,
                  cardColors[index]!, // Use the dynamic color from the map
                ),
            );
        },
      ),
    ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: scoreKeeper,
                ),
              ],
            ),
          ),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }
}

Widget cardContainer(String imagePath, Color borderColor) {
  return Card(
    elevation: 4, // Slight elevation for shadow
    margin: const EdgeInsets.all(9), // Margin around the card
    child: Padding(
      padding: const EdgeInsets.all(9), // Inner padding for content
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 5), // Border with blue color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Center(
          child: Image.asset(
            imagePath.isNotEmpty ? imagePath : 'assets/images/colors.png', // Use provided image or default
            fit: BoxFit.contain, // Ensure the image fits well inside the container
          ),
        ),
      ),
    ),
  );
}
