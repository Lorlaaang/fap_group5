import 'package:flutter/material.dart';

class FlashcardsShapesPage extends StatefulWidget {
  const FlashcardsShapesPage({super.key});

  @override
  State<FlashcardsShapesPage> createState() => _FlashcardsShapesPageState();
}

class _FlashcardsShapesPageState extends State<FlashcardsShapesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Flashcards Animals Page'
        ),
      ),
    );;
  }
}
