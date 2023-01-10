import 'package:flutter/material.dart';
import 'package:heal/screens/home.dart';
import 'package:heal/models/exercises.dart';
import 'package:flip_card/flip_card.dart';
import 'package:heal/services/service_request.dart';

import 'package:heal/services/cache.dart' as cache;

class ExerciseDetailsScreen extends StatefulWidget {
  final String exercise;

  const ExerciseDetailsScreen({Key? key, required this.exercise})
      : super(key: key);

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  List<ExerciseObject> exercises = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  loadExercises() async {
    if (cache.typeCache[widget.exercise] != null) {
      exercises = cache.typeCache[widget.exercise] ?? [];
    } else {
      exercises = await getExercisesList(type: widget.exercise);
      cache.typeCache[widget.exercise] = exercises;
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Flexible(
                flex: 3,
                child: banner("assets/exercises/${widget.exercise}.png",
                title: "Exercises for ${widget.exercise.replaceAll("_", " ")
                    .toTitleCase()}"),
              ),
              Flexible(
                  flex: 7,
                  child: Visibility(
                    visible: isLoaded,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: exercises == [] ? errorScreen() :
                    ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 12, left: 12, right: 12,
                          ),
                          child: displayExercise(
                              "${index+1}. ${exercises[index].name}",
                              exercises[index].type,
                              exercises[index].muscle,
                              exercises[index].equipment,
                              exercises[index].difficulty,
                              exercises[index].instructions),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ));
  }
}

Widget displayExercise(name, type, muscle, equipment, difficulty,
    instructions) {
  return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: FlipCard(
        front: Padding(
            padding: const EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                          name,
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xfffa3754),
                              fontSize: 24),
                      ),
                    ),
                    Tooltip(
                      message: "Difficulty",
                      child: Chip(label: Text(difficulty.toString().toCapitalized()),
                        backgroundColor: difficultyColor(difficulty.toString()),
                        side: const BorderSide(color: Colors.transparent),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Tooltip(message: "Muscle", child: Chip(label: Text("💪 ${muscle.toString().toCapitalized()}".replaceAll("_", " ")),)),
                      const SizedBox(width: 12,),
                      Tooltip(
                        message: "Equipment",
                        child: Chip(label: Text(equipmentString(equipment.toString()))
                        ),
                      )
                    ],
                  ),
                ),

              ],
            )),
          back: RichText(
              text: TextSpan(
                  text: "Instructions: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                  children: [
                    TextSpan(
                        text: "\n${instructions.toString()}",
                        style: const TextStyle(fontSize: 4))
                ]),
          ),
      ));
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ')
          .split(' ')
          .map((str) => str.toCapitalized())
          .join(' ');
}

Color difficultyColor(String type) {
  if (type == "beginner") {
    return Colors.green;
  } else if (type == "intermediate") {
    return Colors.orangeAccent;
  } else {
    return Colors.redAccent;
  }
}

String equipmentString(String equipment) {
  if (equipment.startsWith("body")) {
    return "🏋️ Body Only";
  } else if (equipment.startsWith("machine")) {
    return "⚙️ Machine";
  }else {
    return "ℹ  Others";
  }
}

Widget errorScreen() {
  return const Center(child:
    Text("Something went wrong!")
  );
}