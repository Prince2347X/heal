import 'package:flutter/material.dart';
import 'package:heal/screens/exercises_by_type.dart';
import 'package:heal/screens/home.dart';
import 'package:heal/services/cache.dart' as cache;

import '../models/nutrition.dart';
import '../services/service_request.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  NutritionObject? nutritionObject;
  bool empty = true;
  bool isLoaded = false;
  bool show = false;
  TextEditingController foodInput = TextEditingController();

  getNutritionData(String foodItem) async {
    if (cache.nutritionCache[foodItem] != null) {
      nutritionObject = cache.nutritionCache[foodItem];
    } else {
      nutritionObject = await fetchNutritionInfo(foodItem);
      cache.nutritionCache[foodItem] = nutritionObject;
    }
    setState(() {
      isLoaded = true;
    });
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
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
                              setState(() {
                                isLoaded = false;
                                show = true;
                                getNutritionData(foodItem);
                              });
                            },
                            textInputAction: TextInputAction.search,
                            controller: foodInput,
                            cursorColor: const Color(0xffFC3E66),
                            cursorWidth: 2,
                            cursorHeight: 18,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabled: true,
                                hintText: "Search any food item..."),
                          ),
                        ),
                        IconButton(
                          tooltip: "Get nutrition info",
                          disabledColor: Colors.grey,
                          color: const Color(0xffFC3E66),
                          onPressed: empty
                              ? null
                              : () {
                                  setState(() {
                                    isLoaded = false;
                                    show = true;
                                    getNutritionData(foodInput.text);
                                  });
                                },
                          icon: const Icon(
                            Icons.search,
                          ),
                          splashRadius: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(flex: 1),
          show ? nutritionInfo(context, nutritionObject, isLoaded: isLoaded) : Container()
        ]),
      ),
    );
  }
}

Widget nutritionInfo(BuildContext context, NutritionObject? nutritionObject,
    {bool isLoaded = false}) {
  TextStyle elementStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.3,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          color: Colors.white,
          child: isLoaded
              ? nutritionObject != null
                  ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nutritionObject.name.toCapitalized(),
                              style: const TextStyle(
                                  fontSize: 56,
                                  color: Color(0xffFC3E66),
                                  fontWeight: FontWeight.bold,),
                            ),
                            Text(
                              "Calories: ${nutritionObject.calories}",
                              style: elementStyle
                            ),
                            Text(
                              "Serving Size: ${nutritionObject.servingSize} g",
                              style: elementStyle
                            ),
                            Text(
                              "Fat (Total): ${nutritionObject.fatTotal} g",
                              style: elementStyle
                            ),Text(
                              "Fat (Saturated): ${nutritionObject.fatSaturated} g",
                              style: elementStyle
                            ),Text(
                              "Protein: ${nutritionObject.protein} g",
                              style: elementStyle,
                            ),Text(
                              "Carbohydrates: ${nutritionObject.carbohydrates} g",
                              style: elementStyle
                            ),Text(
                              "Sugar: ${nutritionObject.sugar} g",
                              style: elementStyle
                            ),Text(
                              "Fiber: ${nutritionObject.fiber} g",
                              style: elementStyle
                            ),Text(
                              "Cholesterol: ${nutritionObject.cholesterol} mg",
                              style: elementStyle
                            ),Text(
                              "Sodium: ${nutritionObject.sodium} mg",
                              style: elementStyle
                            ),Text(
                              "Potassium: ${nutritionObject.potassium} mg",
                              style: elementStyle
                            ),
                          ],
                        ),
                    ),
                  )
                  : notFound()
              : const Center(
                  child: CircularProgressIndicator(
                  color: Color(0xffFC3E66),
                ))),
    ),
  );
}

Widget notFound() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("🤔", style: TextStyle(fontSize: 32)),
        Text(
          "Food not found!!",
          style: TextStyle(fontSize: 22),
        )
      ],
    ),
  );
}
