import 'package:flutter/material.dart';
import 'package:forms_demo/signIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: signIN(), // Set the initial screen.
    );
  }
}
