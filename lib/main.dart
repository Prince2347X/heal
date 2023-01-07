import 'package:flutter/material.dart';
import 'package:heal/screens/home.dart';

void main() {
  runApp(const HealApp(

  ));
}

class HealApp extends StatelessWidget {
  const HealApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}