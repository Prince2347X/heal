import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:heal/screens/exercises_by_type.dart';
import 'package:heal/screens/exercises_by_muscle.dart';
import 'package:heal/screens/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: banner("assets/exercises.png"),
          ),
          Flexible(
              flex: 10,
              child: PersistentTabView(
                context,
                controller: _controller,
                screenTransitionAnimation: const ScreenTransitionAnimation(
                    curve: Curves.easeInCirc, duration: Duration(seconds: 1)),
                screens: [
                  listByType(context),
                  listByMuscle(context),
                ],
                items: [
                  PersistentBottomNavBarItem(
                    icon: const Icon(FontAwesome5.list_ul),
                    title: "Types",
                    activeColorPrimary: const Color(0xfffa3754),
                  ),
                  PersistentBottomNavBarItem(
                    icon: const ImageIcon(AssetImage("assets/muscle_icon.png"),
                        size: 38),
                    title: "Muscles",
                    activeColorPrimary: const Color(0xfffa3754),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}

Widget listByMuscle(BuildContext context) {
  List<String> muscleList = [
    "abdominals",
    "abductors",
    "adductors",
    "biceps",
    "calves",
    "chest",
    "forearms",
    "glutes",
    "hamstrings",
    "lats",
    "lower_back",
    "middle_back",
    "neck",
    "quadriceps",
    "traps",
    "triceps"
  ];
  return ListView.builder(
    itemCount: muscleList.length,
      itemBuilder: (context, index) {
    return muscleCard(context, muscleList[index], index);
  });
}

Widget muscleCard(BuildContext context, String muscle, int index) {
  return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ExerciseDetailsByMuscleScreen(muscle: muscle))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
        child: Card(
          elevation: 12,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: Center(
              // padding:
              //     const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text("${index+1}. ${muscle.replaceAll("_", " ").toCapitalized()}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ));
}

ListView listByType(BuildContext context) {
  return ListView(children: [
    exerciseCard(context, "cardio"),
    exerciseCard(context, "olympic_weightlifting"),
    exerciseCard(context, "plyometrics"),
    exerciseCard(context, "strength"),
    exerciseCard(context, "stretching"),
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: exerciseCard(context, "strongman"),
    ),
  ]);
}

Widget exerciseCard(BuildContext context, String exercise) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
    child: InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ExerciseDetailsByTypeScreen(exercise: exercise))),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                  image: AssetImage("assets/exercises/$exercise.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter)),
        ),
      ),
    ),
  );
}
