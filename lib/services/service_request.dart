import 'dart:convert';

import 'package:heal/models/nutrition.dart';
import 'package:http/http.dart' as http;

import 'package:heal/models/exercises.dart';


Future<NutritionObject?> fetchNutritionInfo(String foodItem) async {
  print("Fetched $foodItem");
  Map<String, String> header = {
    "x-api-key": "ZYIZglG9v0UVFZggibFrSg==CbkjNU7ZGJtEQY7o"
  };
  Uri uri = Uri.parse(
      "https://api.api-ninjas.com/v1/nutrition?query=$foodItem");
  var client = http.Client();
  var response = await client.get(uri, headers: header);
  if (response.statusCode == 200) {
    List listOfJson = json.decode(response.body);
    if (listOfJson.isNotEmpty) {
      NutritionObject nutritionObject = NutritionObject.fromJson(listOfJson[0]);
      return nutritionObject;
    }
  }
  return null;
}

Future<List<ExerciseObject>> fetchExercisesList(
    {String type = "", String muscle = ""}) async {
  String toRequest, value;
  if (type != "") {
    toRequest = "type";
    value = type;
  } else {
    toRequest = "muscle";
    value = muscle;
  }
  Map<String, String> header = {
    "x-api-key": "ZYIZglG9v0UVFZggibFrSg==CbkjNU7ZGJtEQY7o"
  };
  Uri uri = Uri.parse(
      "https://api.api-ninjas.com/v1/exercises?$toRequest=$value");
  List<ExerciseObject> exercises = [];


  var client = http.Client();
  var response = await client.get(uri, headers: header);
  if (response.statusCode == 200) {
    var listOfJsonObj = jsonDecode(response.body);
    for (int i = 0; i < listOfJsonObj.length; i++) {
      exercises.add(ExerciseObject.fromJson(listOfJsonObj[i]));
    }
    return exercises;
  } else {
    return [];
  }
}
