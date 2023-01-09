import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:heal/screens/bmi.dart';
import 'package:heal/screens/diet.dart';
import 'package:heal/screens/exercises.dart';
import 'package:heal/screens/meditation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 3,
            child: banner(
              "assets/hello.png",
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 14),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    "“${getQuote()}”",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 30,
                children: [
                  featuresCard(context, const BMIScreen(), FontAwesome5.weight,
                      "BMI", const Color(0xffa72bb5)),
                  featuresCard(
                      context,
                      const ExerciseScreen(),
                      FontAwesome5.dumbbell,
                      "EXERCISE",
                      const Color(0xfffa3754)),
                  featuresCard(
                      context,
                      const MeditationScreen(),
                      FontAwesome5.seedling,
                      "MEDITATION",
                      const Color(0xffff6f0f)),
                  featuresCard(context, const DietScreen(), FontAwesome.food,
                      "DIET", const Color(0xff0f9bff)),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

Widget banner(String imagePath, {String title = ""}) {
  return Stack(children: [
    Material(
      elevation: 18,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        )),
      ),
    ),
    AppBar(
      title: Text(title),
      leadingWidth: 28,
      backgroundColor: Colors.transparent,
      elevation: 0,
    )
  ]);
}

Widget featuresCard(
    BuildContext context, onClick, IconData icon, String text, Color color) {
  return InkWell(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => onClick)),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: color,
        child: Icon(
          icon,
          size: 56,
          color: Colors.white,
        ),
      ),
    ),
  );
}

String getQuote() {
  List<String> quotes = [
    "Exercise not only changes your body, it changes your mind, your attitude and your mood.",
    "Exercise should be regarded as a tribute to the heart.",
    "Good things come to those who sweat.",
    "Of all the paths you take in life, make sure a few of them are dirt.",
    "Take care of your body. It's the only place you have to live.",
    "Healthy is an outfit that looks different on everybody.",
    "A good laugh and a long sleep are the best cures in the doctor's book.",
    "Nothing is impossible. The word itself says I'm possible.",
    "He who has health has hope and he who has hope has everything.",
    "Life expectancy would grow by leaps and bounds if green vegetables smelled as good as bacon.",
    "If you don't like something change it; if you can't change it, change the way you think about it.",
    "Your body will be around a lot longer than that expensive handbag. Invest in yourself.",
    "Your present circumstances don't determine where you can go; they merely determine where you start.",
    "Reading is to the mind what exercise is to the body.",
    "A healthy outside starts from the inside.",
    "It is health that is real wealth and not pieces of gold and silver.",
    "Time and health are two precious assets that we don’t recognize and appreciate until they have been depleted.",
    "Walking is the best possible exercise. Habituate yourself to walk very far.",
    "To enjoy the glow of good health, you must exercise.",
    "True enjoyment comes from activity of the mind and exercise of the body; the two are ever united.",
    "The purpose of training is to tighten up the slack, toughen the body, and polish the spirit.",
    "Number one, like yourself. Number two, you have to eat healthy. That’s my formula."
  ];
  return (quotes..shuffle()).first;
}
