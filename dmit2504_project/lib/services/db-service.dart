
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
        onCreate: (sqflitePackage.Database db1, int version) async {
          await db1.execute(
            "CREATE TABLE rates(name TEXT PRIMARY KEY, price TEXT)",
          );
        },
        version: 1,
      );
      print('db = $db');
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
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
      // Query the table for all The Rates.
      //The .query will return a list with each item in the list being a map.
      final List<Map<String, dynamic>> rateMap = await db.query('rates');
      // Convert the List<Map<String, dynamic> into a List<Rate>.
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
      // Query the table for all The Rates.
      //The .query will return a list with each item in the list being a map.
      final List<Map<String, dynamic>> rateMap = await db.query('rates');
      // Convert the List<Map<String, dynamic> into a List<Rate>.
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

  Future<void> deleteDb() async {
    try {
      await sqflitePackage.deleteDatabase(path);
      print('Db deleted');
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertRate(Rate rate) async {
    try {
      //TODO: 
      //Put code here to insert a stock into the database.
      //Insert the Stock into the correct table. 
      //Also specify the conflictAlgorithm. 
      //In this case, if the same stock is inserted
      //multiple times, it replaces the previous data.
      print("insert rate TRY");
      await db.insert(
        'rates',
        rate.toMap(),
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertRate: $e');
    }
  }

  Future<void> updateRate(Rate rate) async {
    try {
      //TODO: 
      //Put code here to update stock info.
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

  Future<void> deleteRate(Rate rate) async {
    try {
      //TODO: 
      //Put code here to delete a stock from the database.
      await db.delete(
        'rates',
        where: "title = ?",
        whereArgs: [rate.name]
      );
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}