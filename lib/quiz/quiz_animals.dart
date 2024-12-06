import 'package:flutter/material.dart';

class QuizAnimalsPage extends StatefulWidget {
  const QuizAnimalsPage({super.key});

  @override
  State<QuizAnimalsPage> createState() => _QuizAnimalsPageState();
}

class _QuizAnimalsPageState extends State<QuizAnimalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Quiz Animals Page'
        ),
      ),
    );;
  }
}
