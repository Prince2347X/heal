import 'package:flutter/material.dart';
import 'package:heal/screens/home.dart';

import 'package:heal/models/nutrition.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  bool show = false;
  TextEditingController foodInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Flexible(flex: 2, child: banner("assets/nutrition.png")),
          const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 18.0, bottom: 12),
              child: Text(
                "Food nutrition info",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(

              children: [
                strInput(context, "Search any food item", foodInput),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          show = true;
                        });
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(20),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffFC3E66)),
                      ),
                      child: const Text("Calculate"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          show ? nutritionInfo(context) : Container()
        ]),
      ),
    );
  }
}

Widget strInput(
    BuildContext context, String hint, TextEditingController controller) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.08,
    child: Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.69,
                child: TextField(
                  onSubmitted: (foodItem) {
                    search(foodItem);
                  },
                  textInputAction: TextInputAction.search,
                  controller: controller,
                  cursorColor: const Color(0xffFC3E66),
                  cursorWidth: 2,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      border: InputBorder.none, enabled: true, hintText: hint),
                ),
              ),
              IconButton(
                onPressed: () {
                  search(controller.text);
                },
                icon: const Icon(
                  Icons.search,
                  color: Color(0xffFC3E66),
                ),
                splashRadius: 20,
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget nutritionInfo(BuildContext context, {NutritionObject? nutritionInfo}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.4,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14
            )
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text("Food Item", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
            Text("Hmm", style: TextStyle(fontSize: 56, color: Color(0xffa72bb5), fontWeight: FontWeight.bold),),
          ],),
      ),
    ),
  );
}

//TODO: Define the function to fetch data from API
search(String foodItem) {
  print(foodItem);
}
