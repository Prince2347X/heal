import '../models/exercises.dart';
import '../models/nutrition.dart';

Map<String, List<ExerciseObject>> typeCache = {}; // type: ExerciseObjectList
Map<String, List<ExerciseObject>> muscleCache = {}; // muscle: ExerciseObjectList

Map<String, NutritionObject?> nutritionCache = {};
