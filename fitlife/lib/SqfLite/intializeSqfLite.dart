import 'dart:developer';
import 'dart:typed_data';

import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLite {
  dynamic database;

  configSqfLite() async {
    database = await openDatabase(
      join(await getDatabasesPath(), "FitnessApp"),
      version: 1,
      onCreate: (db, version) async {
        //  USER DATA TABLE
        await db.execute("""
        CREATE TABLE USERDATA(
          USERNAME TEXT,
          PASSWOARD TEXT,
          EMAIL TEXT,
          GENDER TEXT,
          ID TEXT PRIMARY KEY,
          COLORISGOAL TEXT,
          AGE TEXT,
          GOAL TEXT,
          HEIGHT TEXT,
          WEIGHT TEXT
        )
""");
        // WATER INTAKE TABLE
        db.execute("""
    
    CREATE TABLE WATERINTAKE(
    TOTALWATER INTEGER,
    DATE TEXT PRIMARY KEY

    )
   """);

        log("WATERDATA Table Created");

        //  WORKOUTSCHEDULE  TABLE

        await db.execute("""
          CREATE TABLE WORKOUTSCHEDULE(
          DATE TEXT ,
          TIME TEXT PRIMARY KEY,
          WORKOUTTYPE TEXT
          )
""");
        log("WORKOUTSCHEDULE Table Created");

        db.execute("""
            CREATE TABLE PROFILEPIC(
              PIC BLOB
            )

""");
      },
    );

    log("DATABASE CREATED HERE:$database");
  }

// getToday Date
  String getCurrentDate() {
    final DateTime now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }
// Insert DATA

  insertData(Map<String, dynamic> data) async {
    Database localdb = await database;
    int id = await localdb.insert("USERDATA", data);
    log("DATA INSERTED WITH ID :$id");
    log("INSERTED DATA IŞ $data");
  }

  //Insert or  Upadate water Intake

  insertOrUpdateWaterIntake(int WaterAmount) async {
    Database localdb = await database;
    String today = getCurrentDate();

    List<Map<String, dynamic>> waterDataList =
        await localdb.query("WATERINTAKE", where: "DATE=?", whereArgs: [today]);
    if (waterDataList.isEmpty) {
      await localdb
          .insert("WATERINTAKE", {"TOTALWATER": WaterAmount, "DATE": today});
      log("Water inserted on $today  for liter $WaterAmount");
    } else {
      int oldWater = waterDataList[0]['TOTALWATER'];
      int newWater = oldWater + WaterAmount;
      await localdb.update("WATERINTAKE", {"TOTALWATER": newWater},
          where: "DATE=?", whereArgs: [today]);
      log("Updated water intake: $newWater ml for $today");
    }
  }

// get Today Water Intake
  getTodayWaterIntake() async {
    Database localdb = await database;
    String today = getCurrentDate();

    final List<Map<String, dynamic>> waterData = await localdb.query(
      'WATERINTAKE',
      where: 'date = ?',
      whereArgs: [today],
    );

    if (waterData.isNotEmpty) {
      log("TODAY WATER: ${waterData[0]['TOTALWATER']}");
      return waterData[0]['TOTALWATER'];
    } else {
      return 0; // No water intake recorded for today
    }
  }

// Get DATA

  getData() async {
    Database localdb = await database;
    List dataList = await localdb.query(
      "USERDATA",
    );
    log("GETDATA:$dataList");
    return dataList;
  }

  // Delete Data

  deleteData(String id) async {
    Database localdb = await database;
    await localdb.delete("USERDATA", where: "ID=?", whereArgs: [id]);
    log("DATA DELETED WITH ID :$id");
  }

  // WORKOUTSCHEDULE

  insertWorkout(String date, String time, String workout) async {
    Database localdb = await database;

    await localdb.insert("WORKOUTSCHEDULE",
        {"DATE": date, "TIME": time, "WORKOUTTYPE": workout});

    List<Map<String, dynamic>> workoutData =
        await localdb.query("WORKOUTSCHEDULE");
    log("WORKOUT INSERTED $workoutData");
  }

  getWorkoutData() async {
    Database localdb = await database;

    List<Map<String, dynamic>> workoutData =
        await localdb.query("WORKOUTSCHEDULE");
    return workoutData;
  }

  insertPic(Uint8List picbyte) async {
    Database localdb = await database;
    await localdb.insert("PROFILEPIC", {"PIC": picbyte});
    log("IMAGE BYTES $picbyte");
  }

  getPic() async {
    Database localdb = await database;
    List<Map<String, dynamic>> pic = await localdb.query("PROFILEPIC");
    return pic[0]['PIC'];
  }
}
