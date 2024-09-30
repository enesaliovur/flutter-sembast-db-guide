import 'dart:math';

import 'package:how_to_use_sembast_db/data/models/food_data.dart';

class RandomFoodGenerator {
  static final _foods = [
    const FoodData(name: 'Lahmacun', isLiked: true),
    const FoodData(name: 'Mantı', isLiked: true),
    const FoodData(name: 'Kuru Fasulye', isLiked: false),
    const FoodData(name: 'Dolma', isLiked: true),
    const FoodData(name: 'Menemen', isLiked: true),
    const FoodData(name: 'Adana Kebap', isLiked: false),
  ];

  static FoodData getRandomFood() {
    return _foods[Random().nextInt(_foods.length)];
  }
}
