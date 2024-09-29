import 'package:how_to_use_sembast_db/data/models/food_data.dart';
import 'package:kt_dart/kt.dart';

abstract class IFoodDataDao {
  // Method to insert new food data
  Future<void> insert(FoodData foodData);

  // Method to update existing food data
  Future<void> update(FoodData foodData);

  // Method to delete food data
  Future<void> delete(FoodData foodData);

  // Method to retrieve all food data sorted by name
  Future<KtList<FoodData>> getAllSortedByName();
}
