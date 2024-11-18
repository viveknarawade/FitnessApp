import 'dart:developer';

import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLite {
  dynamic database;

  configSqfLite() async {
    database = await openDatabase(join(await getDatabasesPath(), "FitnessApp"),
        version: 1, onCreate: (db, version) async {
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
    });
    log("DATABASE CREATED HERE:$database");
  }

// Insert DATA

  insertData(Map<String, dynamic> data) async {
    Database localdb = await database;
    int id = await localdb.insert("USERDATA", data);
  log("DATA INSERTED WITH ID :$id");
  log("INSERTED DATA IŞ $data");
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

  deleteData(String id)async{
    Database localdb = await database;
    await localdb.delete("USERDATA",where: "ID=?",whereArgs: [id]);
  log("DATA DELETED WITH ID :$id");


}


}