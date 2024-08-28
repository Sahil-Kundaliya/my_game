import 'package:flutter/material.dart';

class GameMenuScreen extends StatefulWidget {
  const GameMenuScreen({super.key});
  static const String gameMenuScreen = '/GameMenuScreen';

  @override
  State<GameMenuScreen> createState() => _GameMenuScreenState();
}

class _GameMenuScreenState extends State<GameMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Menu'),
      ),
      body: const Center(
        child: Text('Game Menu'),
      ),
    );
  }
}
