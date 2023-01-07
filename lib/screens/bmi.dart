import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  bool show = false;
  TextEditingController height = TextEditingController();
  TextEditingController weight  = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 3,
                    child: banner("assets/bmi.png"),
                  ),
                  const Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: 18.0, bottom: 12),
                      child: Text(
                        "BMI Calculator",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              input(context, "Height (in cm)", height),
                              input(context, "Weight (in Kg)", weight),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.055,
                              width: MediaQuery.of(context).size.width * 0.83,
                              child: ElevatedButton(onPressed: () {
                                setState(() {
                                  show = true;
                                });
                                // showDialog(context: context, builder: (_) => AlertDialog(
                                //   elevation: 20,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(12)
                                //   ),
                                //   title: const Text("BMI Value"),
                                //   content: SizedBox(
                                //     height: 200,
                                //     width: 200,
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       children: [
                                //
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(vertical: 18.0),
                                //       child: Text("${getBmi(height.text, weight.text)}".substring(0, 4),
                                //       style: const TextStyle(
                                //         fontSize: 28,
                                //         color: Color(0xffa72bb5),
                                //         fontWeight: FontWeight.bold
                                //       ),),
                                //     ),
                                //     bmiTextWidget(getBmi(height.text, weight.text))
                                //   ],),)
                                // ));
                              },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(20),
                                  backgroundColor: MaterialStateProperty.all(const Color(0xffa72bb5)),

                                ), child: const Text("Calculate"),),
                            ),
                          ),
                        ],
                      )),
                  show ? bmiWidget(context, int.parse(height.text), int.parse(weight.text)) : Container()
                ]
            )
        )
    );
  }
}
// bmiWidget(context, int.parse(height.text), int.parse(weight.text))


Widget bmiTextWidget(double bmi) {
  String bmiText = "";
  Color color = Colors.black;
  if (bmi < 18.5) {
    bmiText = "Underweight";
    color = const Color(0xff0097E4);
  } else if (bmi > 18.5 && bmi < 24.9) {
    bmiText = "Normal";
    color = const Color(0xff3AB701);
  } else if (bmi > 25 && bmi < 29.9) {
    bmiText = "Overweight";
    color = const Color(0xffFFC102);
  } else if (bmi >= 30) {
    bmiText = "Obesity";
    color = const Color(0xffEA1C05);
  }
  return Text(bmiText, style: TextStyle(
      color: color,
      fontSize: 38,
      fontWeight: FontWeight.bold
  ),);
}

double getBmi(String height, String weight) {
  int h = int.parse(height);
  int w = int.parse(weight);
  return w/((h/100)*(h/100));
}

Widget bmiWidget(BuildContext context, int height, int weight) {

  double bmi = weight/((height/100)*(height/100));

  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    height: MediaQuery.of(context).size.height * 0.3,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14
            )
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("BMI Value", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
            Text("$bmi".substring(0, 4), style: const TextStyle(fontSize: 56, color: Color(0xffa72bb5), fontWeight: FontWeight.bold),),
            bmiTextWidget(bmi)
          ],),
      ),
    ),
  );
}

Widget input(BuildContext context, String text, TextEditingController controller) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    height: MediaQuery.of(context).size.height * 0.08,
    child: Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: controller,
            cursorColor: const Color(0xffa72bb5),
            cursorWidth: 4,
            cursorHeight: 22,
            decoration: InputDecoration(
                border: InputBorder.none,
                enabled: true,
                hintText: text),
          ),
        ),
      ),
    ),
  );
}
