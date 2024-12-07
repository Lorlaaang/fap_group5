import 'dart:math';
import 'quiz_item.dart';

class Quiz_Brain {
  int _questionNumber = 0;

  String getCorrectImageName(List<Quiz_Item> quizBank)
  {
    return quizBank[_questionNumber].imageName;
  }

  String getImagePath(List<Quiz_Item> quizBank)
  {
    return quizBank[_questionNumber].imagePath;
  }

  String getAudioPath(List<Quiz_Item> quizBank)
  {
    return quizBank[_questionNumber].audioPath;
  }

  void nextQuestion(List<Quiz_Item> quizBank) {
    if(_questionNumber < quizBank.length - 1) {
      _questionNumber++;
    }
  }

  void restartQuiz() {
    _questionNumber = 0;
  }

  bool isFinished(List<Quiz_Item> quizBank) {
    if(_questionNumber == quizBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  List<Quiz_Item> getRandomizedItems(List<Quiz_Item> quizBank)
  {
    Quiz_Item correctItem = quizBank[_questionNumber];

    // Create a copy of quizBank to avoid modifying the original list
    List<Quiz_Item> options = List.from(quizBank);

    // Remove the correct item from the options list
    options.remove(correctItem);

    // Shuffle the remaining items
    options.shuffle(Random());

    // Select the first 3 random items
    List<Quiz_Item> randomItems = options.take(3).toList();

    // Add the correct answer back into the options
    randomItems.add(correctItem);

    // Shuffle again to randomize the order
    randomItems.shuffle(Random());

    return randomItems;
  }
}