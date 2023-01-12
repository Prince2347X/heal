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
  bool empty = true;
  TextEditingController foodInput = TextEditingController();

//TODO: Define the function to fetch data from API
  search(String foodItem) {
    setState(() {
      show = true;
    });
    print(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Flexible(flex: 3, child: banner("assets/nutrition.png")),
          const Flexible(
            flex: 2,
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
            flex: 3,
            child: SizedBox(
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
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  empty = false;
                                });
                              } else {
                                setState(() {
                                  empty = true;
                                  show = false;
                                });
                              }
                            },
                            onSubmitted: (foodItem) {
                              search(foodItem);
                            },
                            textInputAction: TextInputAction.search,
                            controller: foodInput,
                            cursorColor: const Color(0xffFC3E66),
                            cursorWidth: 2,
                            cursorHeight: 18,
                            decoration: const InputDecoration(
                                border: InputBorder.none, enabled: true, hintText: "Search any food item..."),
                          ),
                        ),
                        IconButton(
                          onPressed: empty ? null : () {
                            search(foodInput.text);
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
            ),
            // child: strInput(context, "Search any food item", foodInput, search),
          ),
          const Spacer(flex: 1),
          show ? nutritionInfo(context, foodItem: foodInput.text) : Container()
        ]),
      ),
    );
  }
}

Widget nutritionInfo(BuildContext context, {NutritionObject? nutritionInfo, String? foodItem}) {
  final String? food = foodItem;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.3,
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
          children: [
            const Text("Food Item", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
            Text(food ?? "None", style: TextStyle(fontSize: 56, color: Color(0xffa72bb5), fontWeight: FontWeight.bold),),
          ],),
      ),
    ),
  );
}

