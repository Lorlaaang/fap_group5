import 'package:flutter/material.dart';

class QuizInstrumentsPage extends StatefulWidget {
  const QuizInstrumentsPage({super.key});

  @override
  State<QuizInstrumentsPage> createState() => _QuizInstrumentsPageState();
}

class _QuizInstrumentsPageState extends State<QuizInstrumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Quiz Instruments Page'
        ),
      ),
    );;;
  }
}
