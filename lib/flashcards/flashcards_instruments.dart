import 'package:flutter/material.dart';

class FlashcardsInstrumentsPage extends StatefulWidget {
  const FlashcardsInstrumentsPage({super.key});

  @override
  State<FlashcardsInstrumentsPage> createState() => _FlashcardsInstrumentsPageState();
}

class _FlashcardsInstrumentsPageState extends State<FlashcardsInstrumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Flashcards Instruments Page'
        ),
      ),
    );;
  }
}
