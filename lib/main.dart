import 'package:flutter/material.dart';
import 'package:pilem/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
/// Builds the main widget of the application, which is a MaterialApp
/// with a Scaffold containing a centered "Hello World" text widget.

  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  HomeScreen(),
    );
  }
}
