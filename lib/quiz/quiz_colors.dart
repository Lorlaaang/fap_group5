import 'package:flutter/material.dart';

class QuizColorsPage extends StatefulWidget {
  const QuizColorsPage({super.key});

  @override
  State<QuizColorsPage> createState() => _QuizColorsPageState();
}

class _QuizColorsPageState extends State<QuizColorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Quiz Colors Page'
        ),
      ),
    );
  }
}

