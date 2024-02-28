import 'package:flutter/material.dart';
import 'package:task_assignment/screens/home_screen.dart';
import 'package:task_assignment/screens/login_screen.dart';

late Size mq;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
