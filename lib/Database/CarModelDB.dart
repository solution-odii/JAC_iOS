

import 'dart:io';

import 'package:jac/Models/carsList.dart';
import 'package:jac/Constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:jac/Constants/constants.dart';

class CarsDatabase{
  CarsDatabase._();

  static final CarsDatabase carsDatabase = CarsDatabase._();
  static Database _database;


  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "CarsDB.db");
    return await openDatabase(
        path,
        version: 1,
//        onOpen: (db) {
//    },
        onCreate: (Database db, int version) async {
      await db.execute( "CREATE TABLE Cars ( id INTEGER PRIMARY KEY, code TEXT, type TEXT, description TEXT, category TEXT, extraInfo TEXT, version TEXT)"
      );

    });



  }

  addCarsToDatabase(CarTypes carTypes) async {
    final db = await database;
    var raw = await db.insert(
      "Cars",
      carTypes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(raw);
    return raw;


  }


  updateCars(CarTypes carTypes) async {
    final db = await database;
    var response = await db.update("Cars", carTypes.toMap(),
        where: "id = ?",
        whereArgs: [carTypes.id]);
    return response;
  }


  Future<List<CarTypes>> getAllCars() async {
    final db = await database;
    var response = await db.query("Cars");
    List<CarTypes> list = response.map((c) => CarTypes.fromJson(c)).toList();
    print(list);
    return list;
  }



  Future<List<CarTypes>> getCarCodes() async{
    final db = await database;
    var response = await db.rawQuery('SELECT DISTINCT code FROM Cars');
    List<CarTypes> carCodeList = response.map((c) => CarTypes.fromJson(c)).toList();
    print(carCodeList);
    Constants.carCodes = carCodeList;
    return carCodeList;
  }


  Future<List<CarTypes>> getVehicleType(String type) async{
    
    final db = await database;
    var response = await db.rawQuery('SELECT description FROM Cars WHERE code = ?', [type]);
    List<CarTypes> carDescripList = response.map((c) => CarTypes.fromJson(c)).toList();
    print(carDescripList);
    Constants.carDescription = carDescripList;

    return carDescripList;
  }


}