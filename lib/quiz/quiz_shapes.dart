import 'package:flutter/material.dart';

class QuizShapesPage extends StatefulWidget {
  const QuizShapesPage({super.key});

  @override
  State<QuizShapesPage> createState() => _QuizShapesPageState();
}

class _QuizShapesPageState extends State<QuizShapesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Quiz Shapes Page'
        ),
      ),
    );;;
  }
}
