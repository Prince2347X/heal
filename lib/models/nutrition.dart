class NutritionObject {
  final String name;
  final double calories;
  final double servingSize; //in grams
  final double fatTotal;
  final double fatSaturated;
  final double protein;
  final double carbohydrates;
  final double fiber;
  final double sugar;

  final double sodium; //in mg
  final double potassium; //in mg
  final double cholesterol; //in mg

  const NutritionObject({
    required this.name,
    required this.calories,
    required this.servingSize, //in grams
    required this.fatTotal,
    required this.fatSaturated,
    required this.protein,
    required this.carbohydrates,
    required this.fiber,
    required this.sugar,
    required this.sodium, //in mg
    required this.potassium, //in mg
    required this.cholesterol, //in mg
  });

  factory NutritionObject.fromJson(Map<String, dynamic> json) {
    return NutritionObject(
      name: json['name'],
      calories: json['calories'],
      servingSize: json['serving_size_g'],
      fatTotal: json['fat_total_g'],
      fatSaturated: json['fat_saturated_g'],
      protein: json['protein_g'],
      carbohydrates: json['carbohydrates_total_g'],
      fiber: json['fiber_g'],
      sugar: json['sugar_g'],

      sodium: json['sodium_mg'],
      potassium: json['potassium_mg'],
      cholesterol: json['cholesterol_mg'],
    );
  }
}

// {
// "name": "biryani",
// "calories": 142.9,
// "serving_size_g": 100,
// "fat_total_g": 4.6,
// "fat_saturated_g": 0.8,
// "protein_g": 9.6,
// "sodium_mg": 200,
// "potassium_mg": 91,
// "cholesterol_mg": 23,
// "carbohydrates_total_g": 15,
// "fiber_g": 0.7,
// "sugar_g": 1.6
// },