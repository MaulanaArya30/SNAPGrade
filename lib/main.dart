import 'package:flutter/material.dart';
import 'package:snapgrade/views/buat_kunci.dart';
import 'package:snapgrade/views/dashboard.dart';
import 'package:snapgrade/views/new_quiz.dart';
import 'package:snapgrade/views/periksa_jawaban.dart';
import 'package:snapgrade/views/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: NewquizPage(),
    );
  }
}
