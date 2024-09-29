import 'package:how_to_use_sembast_db/data/database/app_database.dart'; // Importing the database
import 'package:how_to_use_sembast_db/data/dao/i_food_data_dao.dart';
import 'package:how_to_use_sembast_db/data/models/food_data.dart'; // Importing the FoodData model
import 'package:kt_dart/kt.dart'; // For using immutable list from the Kt Dart package
import 'package:sembast/sembast_io.dart'; // For using Sembast database

class FoodDataDao extends IFoodDataDao {
  // The store key (name) for storing food data in the database
  static const String _storeKey = 'food';

  // Creating a store for mapping integer keys to the data (key-value store)
  final _store = intMapStoreFactory.store(_storeKey);

  // Getter to access the database from the AppDatabase singleton instance
  Future<Database> get _db async => await AppDatabase().database;

  // Method to insert new food data into the database
  @override
  Future<void> insert(FoodData foodData) async {
    // Add the food data to the store, automatically generating a key for it
    await _store.add(await _db, foodData.toMap());
  }

  // Method to update existing food data based on its ID (primary key)
  @override
  Future<void> update(FoodData foodData) async {
    // Finder helps to locate the record by its key (ID)
    final finder = Finder(filter: Filter.byKey(foodData.id));

    // Update the record with the new data in the database
    await _store.update(
      await _db, // Access the database
      foodData.toMap(), // Map of the updated data
      finder: finder, // Filter to find the exact record
    );
  }

  // Method to delete food data from the database based on its ID
  @override
  Future<void> delete(FoodData foodData) async {
    // Finder to locate the record to delete by its key (ID)
    final finder = Finder(filter: Filter.byKey(foodData.id));

    // Delete the matching record from the database
    await _store.delete(await _db, finder: finder);
  }

  // Method to retrieve all food data sorted by name in ascending order
  @override
  Future<KtList<FoodData>> getAllSortedByName() async {
    // Finder to sort the results by the 'name' field
    final finder = Finder(sortOrders: [SortOrder('name')]);

    // Find all records in the store that match the finder (sorted by name)
    final snapshots = await _store.find(await _db, finder: finder);

    // Convert each snapshot to a FoodData object and return as an immutable list
    return snapshots.map(
      (snapshot) {
        final foodData =
            FoodData.fromMap(snapshot.value); // Create FoodData from the map
        return foodData.copyWith(
          id: snapshot.key,
        ); // Assign the key (ID) to the FoodData object
      },
    ).toImmutableList(); // Return the list as an immutable KtList
  }
}
