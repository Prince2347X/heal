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
    return MaterialApp(
      theme: ThemeData(
          chipTheme: ChipThemeData(
              labelStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            side: BorderSide(color: Colors.grey.shade400, width: 2),
            backgroundColor: Colors.transparent,

          )
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}