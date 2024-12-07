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
  }

  List<Icon> scoreKeeper = [];
  Quiz_Brain quizBrain = new Quiz_Brain();
  int score = 0;

  final List<Quiz_Item> quizBank = [
    Quiz_Item('RED', 'assets/images/red.png', 'audio/red.mp3'),
    Quiz_Item('BLUE', 'assets/images/blue.png', 'audio/blue.mp3'),
    Quiz_Item('YELLOW', 'assets/images/yellow.png', 'audio/yellow.mp3'),
    Quiz_Item('GREEN', 'assets/images/green.png', 'audio/green.mp3'),
    Quiz_Item('ORANGE', 'assets/images/orange.png', 'audio/orange.mp3'),
    Quiz_Item('PURPLE', 'assets/images/purple.png', 'audio/purple.mp3'),
    Quiz_Item('PINK', 'assets/images/pink.png', 'audio/pink.mp3'),
    Quiz_Item('BROWN', 'assets/images/brown.png', 'audio/brown.mp3'),
    Quiz_Item('BLACK', 'assets/images/black.png', 'audio/black.mp3'),
    Quiz_Item('GRAY', 'assets/images/gray.png', 'audio/gray.mp3'),
  ];

  List<Quiz_Item> randomizedCards = [];

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
              itemCount: 4,
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
                      // Check if the selected card is correct
                      checkAnswer(selectedImageName);

                      // Move to the next question if not finished
                      if (!quizBrain.isFinished(quizBank)) {
                        quizBrain.nextQuestion(quizBank); // Increment the question
                        randomizedCards = quizBrain.getRandomizedItems(quizBank); // Generate new options
                      } else {
                        // Restart the quiz if finished
                        scoreKeeper = [];
                        quizBrain.restartQuiz();
                        randomizedCards = quizBrain.getRandomizedItems(quizBank);
                        // Show the alert after a delay
                        Future.delayed(Duration(seconds: 1), () {
                          Alert(
                            context: context,
                            title: 'Finished',
                            desc: 'You scored $score / 10.',
                            buttons: [
                              DialogButton(
                                child: Center(
                                  child: Text(
                                    'Home Page',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // Close the alert
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                width: null, // Allow button width to fit the text
                              ),
                              DialogButton(
                                child: Center(
                                  child: Text(
                                    'Review Colors',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // Close the alert
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FlashcardsColorsPage()),
                                  );
                                },
                                width: null, // Allow button width to fit the text
                              ),
                            ],
                          ).show();
                        });
                      }
                    });

                  },
                  child: Container(
                    child: cardContainer(randomizedCards[index].imagePath),
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

Widget cardContainer(String imagePath) {
  return Card(
    elevation: 4, // Slight elevation for shadow
    margin: const EdgeInsets.all(9), // Margin around the card
    child: Padding(
      padding: const EdgeInsets.all(9), // Inner padding for content
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2), // Border with blue color
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
