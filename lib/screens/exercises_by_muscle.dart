import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:heal/services/cache.dart' as cache;
import 'package:heal/services/service_request.dart';

import '../models/exercises.dart';
import 'exercises_by_type.dart';

class ExerciseDetailsByMuscleScreen extends StatefulWidget {
  final String muscle;

  const ExerciseDetailsByMuscleScreen({Key? key, required this.muscle})
      : super(key: key);

  @override
  State<ExerciseDetailsByMuscleScreen> createState() =>
      _ExerciseDetailsByMuscleScreenState();
}

class _ExerciseDetailsByMuscleScreenState
    extends State<ExerciseDetailsByMuscleScreen> {
  List<ExerciseObject> exercises = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  loadExercises() async {
    if (cache.muscleCache[widget.muscle] != null) {
      exercises = cache.muscleCache[widget.muscle] ?? [];
    } else {
      exercises = await fetchExercisesList(muscle: widget.muscle);
      cache.muscleCache[widget.muscle] = exercises;
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
          // Flexible(
          //   flex: 3,
          //   child: banner("assets/exercises.png",
          //       title:
          //       "Exercises for ${widget.muscle.replaceAll("_", " ").toTitleCase()} muscle"),
          // ),
          Flexible(
              flex: 7,
              child: Visibility(
                visible: isLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: exercises == []
                    ? errorScreen()
                    : ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 12,
                              right: 12,
                            ),
                            child: displayExercise(
                                context,
                                "${index + 1}. ${exercises[index].name}",
                                exercises[index].type,
                                exercises[index].muscle,
                                exercises[index].equipment,
                                exercises[index].difficulty,
                                exercises[index].instructions),
                          );
                        },
                      ),
              )),
        ],
      ),
    ));
  }
}

Widget displayExercise(BuildContext context, name, type, muscle, equipment,
    difficulty, instructions) {
  return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: FlipCard(
        front: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 8),
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
                            color: Color(0xff0f9bff),
                            fontSize: 24),
                      ),
                    ),
                    Tooltip(
                      message: "Difficulty",
                      child: Chip(
                        label: Text(difficulty.toString().toCapitalized()),
                        backgroundColor: difficultyColor(difficulty.toString()),
                        side: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Tooltip(
                          message: "Type",
                          child: Chip(
                            label: Text(
                                "❓ ${type.toString().toCapitalized()}"
                                    .replaceAll("_", " ")),
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Tooltip(
                        message: "Equipment",
                        child: Chip(
                            label: Text(equipmentString(equipment.toString()))),
                      )
                    ],
                  ),
                ),
              ],
            )),
        back: SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Instructions: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    instructions.toString(),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}
