import 'package:flutter/material.dart';
import 'package:rentyne/screens/get_started/get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rentyne',
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
