import 'dart:async'; // Importing asynchronous programming support

import 'package:path_provider/path_provider.dart'; // For getting the application document directory
import 'package:sembast/sembast_io.dart'; // For Sembast database operations
import 'package:path/path.dart'; // For manipulating paths

class AppDatabase {
  // Singleton instance of AppDatabase
  static final AppDatabase _instance = AppDatabase._internal();

  // Private constructor to prevent external instantiation
  AppDatabase._internal();

  // Factory constructor to return the singleton instance
  factory AppDatabase() => _instance;

  // Completer for managing the database opening process
  Completer<Database>? _dbOpenCompleter;

  // Getter for accessing the database
  Future<Database> get database async {
    // Check if the Completer is null (database is not yet opened)
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer(); // Create a new Completer
      await _openDatabase(); // Attempt to open the database
    }

    // Return the future of the Completer, which will complete once the database is opened
    return _dbOpenCompleter!.future;
  }

  // Asynchronous method to open the database
  Future<void> _openDatabase() async {
    try {
      // Get the application's document directory
      final appDocumentDir = await getApplicationDocumentsDirectory();
      // Create the database path
      final dbPath = join(appDocumentDir.path, 'app.db');
      // Open the database at the specified path
      final database = await databaseFactoryIo.openDatabase(dbPath);

      // Complete the Completer with the opened database
      _dbOpenCompleter?.complete(database);
    } catch (e) {
      // Complete the Completer with an error if opening the database fails
      _dbOpenCompleter?.completeError(e);
    }
  }
}
