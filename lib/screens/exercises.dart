import 'package:flutter/material.dart';
import 'package:heal/screens/exerciseDetails.dart';
import 'package:heal/screens/home.dart';


class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(children: [
        Flexible(flex: 3, child: banner("assets/exercises.png"),),
        Flexible(flex: 7,
          child: ListView(children: [
            const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                "Do some exercise",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                    color: Color(0xfffa3754)),
              ),
            ),
            exerciseCard(context, "cardio"),
            exerciseCard(context, "olympic_weightlifting"),
            exerciseCard(context, "plyometrics"),
            exerciseCard(context, "strength"),
            exerciseCard(context, "stretching"),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: exerciseCard(context, "strongman"),
            ),
          ]),)
      ],),
    ));
  }
}

Widget exerciseCard(BuildContext context, String exercise) {
  return InkWell(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ExerciseDetailsScreen(exercise: exercise))),
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
      child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset("assets/exercises/$exercise.png"),)
      ),
    ),
  );
}