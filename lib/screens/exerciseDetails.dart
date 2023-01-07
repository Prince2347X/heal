import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heal/screens/home.dart';
import 'package:heal/screens/models/exercises.dart';

import 'package:http/http.dart' as http;


class ExerciseDetailsScreen extends StatefulWidget {
  final String exercise;

  const ExerciseDetailsScreen({Key? key, required this.exercise})
      : super(key: key);

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  List<Exercises> exercises = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var client = http.Client();
    var response = await client.get(Uri.parse("https://api.api-ninjas.com/v1/exercises?type=${widget.exercise}"), headers: {"x-api-key": "ZYIZglG9v0UVFZggibFrSg==CbkjNU7ZGJtEQY7o"});
    if (response.statusCode == 200) {
      var listOfJsonObj = jsonDecode(response.body);
      for (int i = 0; i<listOfJsonObj.length; i++) {
        exercises.add(Exercises.fromJson(listOfJsonObj[i]));
      }
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: banner("assets/exercises/${widget.exercise}.png"),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 12),
              child: Text(
                "Exercises for ${widget.exercise.replaceAll("_", " ").toTitleCase()}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfffa3754)),
              ),
            ),
          ),
          Flexible(
              flex: 6,
              child: Visibility(
                visible: isLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return displayExercise(
                        exercises[index].name,
                        exercises[index].type,
                        exercises[index].muscle,
                        exercises[index].equipment,
                        exercises[index].difficulty,
                        exercises[index].instructions);
                  },
                ),
              ))
        ],
      ),
    ));
  }
}

Widget displayExercise(
    name, type, muscle, equipment, difficulty, instructions) {
  TextStyle baseStyle = const TextStyle(fontSize: 9, color: Colors.black54);
  TextStyle headerStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87);
  return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xfffa3754),
                    fontSize: 24),
              ),
              RichText(
                  text: TextSpan(text: "Type: ", style: headerStyle, children: [
                TextSpan(
                    text: type.toString().toCapitalized(), style: baseStyle)
              ])),
              RichText(
                  text: TextSpan(
                      text: "Muscle: ",
                      style: headerStyle,
                      children: [
                    TextSpan(
                        text: muscle.toString().toCapitalized(),
                        style: baseStyle)
                  ])),
              RichText(
                  text: TextSpan(
                      text: "Equipment: ",
                      style: headerStyle,
                      children: [
                    TextSpan(
                        text: equipment.toString().toCapitalized(),
                        style: baseStyle)
                  ])),
              RichText(
                  text: TextSpan(
                      text: "Difficulty: ",
                      style: headerStyle,
                      children: [
                    TextSpan(
                        text: difficulty.toString().toCapitalized(),
                        style: baseStyle)
                  ])),
              RichText(
                  text: TextSpan(
                      text: "Instructions: ",
                      style: headerStyle,
                      children: [
                    TextSpan(
                        text: "\n${instructions.toString()}",
                        style: const TextStyle(fontSize: 6))
                  ])),
            ],
          )));
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
