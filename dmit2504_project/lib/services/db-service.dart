
import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;
import '../models/rate.dart';

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'rates_database.db');
      db = await sqflitePackage.openDatabase(
        path,
        onCreate: _onCreate,
        version: 1,
      );
      print('db = $db');
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

 Future<void> _onCreate(sqflitePackage.Database db, int version) async {
  await db.execute(
    "CREATE TABLE rates(name TEXT PRIMARY KEY, price TEXT)",
  );
  await db.execute(
    "CREATE TABLE history(name TEXT PRIMARY KEY, price TEXT)",
  );
  await db.execute(
    "CREATE TABLE favourites(name TEXT PRIMARY KEY, price TEXT)",
  );
  print(db);
}
 Future<void> printAllRatesInDbToConsole() async {
    try {
      List<Rate> listOfRates = await getAllRatesFromDb();
      if (listOfRates.isEmpty) {
        print('No Favourites in the list');
      } else {
        for (var rate in listOfRates) {
          print(
              'name: ${rate.name}, price: ${rate.price}}');
        }
      }
    } catch (e) {
      print('SQFliteDbService printAllFavouritesInDbToConsole: $e');
    }
  }
  Future<void> printAllFavouritesInDbToConsole() async {
    try {
      List<Rate> listOfFavourites = await getAllFavouritesFromDb();
      if (listOfFavourites.isEmpty) {
        print('No Favourites in the list');
      } else {
        for (var rate in listOfFavourites) {
          print(
              'name: ${rate.name}, price: ${rate.price}}');
        }
      }
    } catch (e) {
      print('SQFliteDbService printAllFavouritesInDbToConsole: $e');
    }
  }
  Future<List<Rate>> getAllFavouritesFromDb() async{
    try {
      final List<Map<String, dynamic>> rateMap = await db.query('favourites');
      return List.generate(rateMap.length, (i) {
        return Rate(
          name: rateMap[i]['name'],
          price: rateMap[i]['price'],
        );
      });
    } catch (e) {
      print('SQFliteDbService getAllFavouritesFromDb: $e');
      return [];
    }
  }
  Future<List<Rate>> getAllRatesFromDb() async {
    try {
      final List<Map<String, dynamic>> rateMap = await db.query('rates');
      return List.generate(rateMap.length, (i) {
        return Rate(
          name: rateMap[i]['name'],
          price: rateMap[i]['price'],
        );
      });
    } catch (e) {
      print('SQFliteDbService getAllFavouritesFromDb: $e');
      return [];
    }
  }
  Future<void> printAllHistoryInDbToConsole() async {
    try {
      List<Rate> listOfHistory = await getAllHistoryFromDb();
      if (listOfHistory.isEmpty) {
        print('No Recents in the list');
      } else {
        for (var rate in listOfHistory) {
          print(
              'name: ${rate.name}, price: ${rate.price}}');
        }
      }
    } catch (e) {
      print('SQFliteDbService printAllFavouritesInDbToConsole: $e');
    }
  }
  Future<List<Rate>> getAllHistoryFromDb() async{
    try {
      final List<Map<String, dynamic>> rateMap = await db.query('history');
      return List.generate(rateMap.length, (i) {
        return Rate(
          name: rateMap[i]['name'],
          price: rateMap[i]['price'],
        );
      });
    } catch (e) {
      print('SQFliteDbService getAllHistoryFromDb: $e');
      return [];
    }
  }
  Future<void> deleteDbSearch() async {
    try {
      await db.execute("DROP TABLE IF EXISTS rates");
      print('Db deleted');
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertRate(Rate rate) async {
    try {
      await db.insert(
        'rates',
        rate.toMap(),
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertRate: $e');
    }
  }

    Future<void> insertFavourite(Rate rate) async {
    try {
      print("insert favourite TRY");
      await db.insert(
        'favourites',
        rate.toMap(),
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertRate: $e');
    }
  }

  Future<void> insertHistory(Rate rate) async {
    try {
      print("insert history TRY");
      await db.insert(
        'history',
        rate.toMap(),
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertHistory: $e');
    }
  }
  Future<void> updateRate(Rate rate) async {
    try {
      await db.update(
        'rates',
        rate.toMap(),
        where: "title = ?",
        whereArgs: [rate.name],
      );
    } catch (e) {
      print('SQFliteDbService updateRate: $e');
    }
  }

  Future<void> deleteRate() async {
    try {
      await sqflitePackage.deleteDatabase(path);
      print('Db deleted');
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}