import 'package:flutter/material.dart';
import 'package:heal/screens/exerciseDetails.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:heal/screens/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
                curve: Curves.easeInCirc,
                duration: Duration(seconds: 1)
              ),
              screens: [
                listByType(context),
                exerciseCard(context, "cardio")
              ],
              items: [
                PersistentBottomNavBarItem(icon: const Icon(FontAwesome5.list_ul),
                title: "Types",
                  activeColorPrimary: const Color(0xfffa3754),
                ),
                PersistentBottomNavBarItem(icon: const ImageIcon(AssetImage("assets/muscle_icon.png"),size: 38),
                title: "Muscles",
                  activeColorPrimary: const Color(0xfffa3754),
                )
              ],
            )
          )
        ],
      ),
    ));
  }
}
Widget listByMuscle(BuildContext context) {
  return Container(
  );
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
              builder: (context) => ExerciseDetailsScreen(exercise: exercise))),
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
        // child: Container(
        //   height: MediaQuery.of(context).size.height * 0.2,
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(14),
        //     child: Image.asset("assets/exercises/$exercise.png"),
        //   ),
        // )
      ),
    ),
  );
}
