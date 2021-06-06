import 'dart:async';

import 'package:jiffy/jiffy.dart';
import 'package:progressor/Model/Database/ProgressTable.dart';
import 'package:progressor/Model/Database/ProgressTrackingTable.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Model/SupportModel/ProgressTracking.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProgressorDB {
  static final ProgressorDB instance = ProgressorDB._init();

  static Database _database;

  ProgressorDB._init();

  //Singleton Setup
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('Progressor.db');
    return _database;

  }

  // Init DB
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
        onUpgrade: _onUpgrade
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  Future _renameCollumn(String tableName, String oldCollumnName, String newCollumnName) async {
    print("Rename");
    var db = await instance.database;
    await db.execute('''
      ALTER TABLE $tableName RENAME COLUMN $oldCollumnName to $newCollumnName;
      '''
    );
  }

  // Create the DB
  Future _createDB(Database db, int version) async {

    await _CreateProgressTable(db, version); //Create Progress Table
    await _CreateProgressTrackingTable(db, version); //Create Progress-Tracking Table
  }

  //Create Progress and insert to the Database
  Future _CreateProgressTable(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE ${ProgressTableFields.TableProgressName} ( 
        ${ProgressTableFields.id} $idType, 
        ${ProgressTableFields.name} $textType,
        ${ProgressTableFields.totalSecond} $integerType,
        ${ProgressTableFields.reminderLst} $textType
        )
      ''');
  }
  Future<int> create(Progress progress) async {
    final db = await instance.database;
    final id = await db.insert(ProgressTableFields.TableProgressName, progress.toJson());
    return id; //TODO: Becareful This is not Correct or True to the former tutorial
  }
  //Delete Progress
  Future<int> delete(Progress progress) async {
    final db = await instance.database;
    return await db.delete(
      ProgressTableFields.TableProgressName,
      where: '${ProgressTableFields.id} = ?',
      whereArgs: [progress.id],
    );
  }
  //Read Progress:
  Future<Progress> readProgress(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      ProgressTableFields.TableProgressName,
      columns: ProgressTableFields.values,
      where: '${ProgressTableFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Progress.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  // Get All Progress
  Future<List<Progress>> getAllProgress() async {
    final db = await instance.database;
    final orderBy = '${ProgressTableFields.id} ASC';
    final result = await db.query(ProgressTableFields.TableProgressName, orderBy: orderBy);
    return result.map((json) => Progress.fromJson(json)).toList();
  }
  // ProgressUpdate



  /*PROGRESS-TRACKING TABLE:
  * */
  Future _CreateProgressTrackingTable(Database db, int version) async {
    print("CREATE NEW TABLE");
    final integerType = 'INTEGER NOT NULL';
    final integerCanNullType = 'INTEGER';

    final primaryCompoundKey = 'PRIMARY KEY';
    await db.execute('''
      CREATE TABLE ${ProgressTrackingTableFields.TableProgressTrackingName} ( 
        ${ProgressTrackingTableFields.progressId} $integerType, 
        ${ProgressTrackingTableFields.year} $integerType,
        ${ProgressTrackingTableFields.week} $integerType,
        ${ProgressTrackingTableFields.second} $integerCanNullType,

        $primaryCompoundKey (
          ${ProgressTrackingTableFields.progressId},
          ${ProgressTrackingTableFields.year},
          ${ProgressTrackingTableFields.week}
         ) 
        )
      ''');
  }

  Future _UpdateProgressTracking(ProgressTracking tracking) async {

    //print("Update Progress Tracking: " + tracking.toString() );
    var db = await instance.database;
    return
      await db.update(ProgressTrackingTableFields.TableProgressTrackingName,
        tracking.toJson(),
        where: '${ProgressTrackingTableFields.progressId} = ?'
            ' and ${ProgressTrackingTableFields.year} = ?'
            ' and ${ProgressTrackingTableFields.week} = ?',
        whereArgs: [tracking.ProgressId, tracking.year, tracking.week]);
  }

  Future GetThisWeekProgressTracking(int ProgressID) async {
    var currentYear= Jiffy().year;
    var currentWeekInYear = Jiffy().week;

    final db = await instance.database;
    final maps = await db.query(
      ProgressTrackingTableFields.TableProgressTrackingName,
      columns: ProgressTrackingTableFields.values,
      where: '${ProgressTrackingTableFields.progressId} = ?'
          ' and ${ProgressTrackingTableFields.year} = ?'
          ' and ${ProgressTrackingTableFields.week} = ?',
      whereArgs: [ProgressID, currentYear, currentWeekInYear],
    );

    if (maps.isNotEmpty) {
      return ProgressTracking.fromJson(maps.first);
    } else {
      return null;
    }

  }

  //Insert new ProgressTracking
  Future<int> insertProgressTracking(ProgressTracking tracking) async{
    final db = await instance.database;
    final id = await db.insert(
        ProgressTrackingTableFields.TableProgressTrackingName, tracking.toJson());
    return id; //TODO: Becareful This is not Correct or True to the former tutorial
  }

  Future UpdateProgressTracking(Progress progress, int newSecond) async {
    var item = await GetThisWeekProgressTracking(progress.id);
    if (item == null){
      //print("Not existed!");
      ProgressTracking newPTrack = ProgressTracking(
        ProgressId: progress.id,
         year: Jiffy().year,
        week: Jiffy().week,
        second: newSecond
      );
      //Create new ProgressTracking Item
      var id = await insertProgressTracking(newPTrack);
      if (id == null) return null;
      else return id;
    }else {
      //print("Update ProgressTracking!");

      //Update old ProgressTracking Item
      if (item is ProgressTracking){
        item.second = newSecond;
        await _UpdateProgressTracking(item);
      }
    }
  }

  //Close DB
  Future close() async {
    final db = await instance.database;

    db.close();
  }



}