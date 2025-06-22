import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals/cubit/main_states.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MainCubit extends Cubit<MainStates>{
  MainCubit() : super(MainInitStates());

  static MainCubit get(context) => BlocProvider.of(context);

  var addTextController = TextEditingController();

  initSql() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              '''CREATE TABLE Goals 
              (
              id INTEGER PRIMARY KEY, 
              name TEXT
              )''');
        });
  }
  List<Map> goalsList = [];
  getData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);

    await database.rawQuery('SELECT * FROM Goals').then((value){
      goalsList = value;
      emit(GetDataSuccessStates());
    }).catchError((onError){
      emit(GetDataErrorStates());
      print(onError.toString());
    });
    database.close();
  }

  insertData(String name) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);

    await database.rawInsert(
        'INSERT INTO Goals(name) VALUES(?)',
        ['$name']).then((value){
      emit(InsertDataSuccessStates());
    }).catchError((onError){
      emit(InsertDataErrorStates());
      print(onError.toString());
    });

    database.close();
  }

  deleteData(id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);

    await database
        .rawDelete('DELETE FROM Goals WHERE id = ?',
        ['$id']).then((value){
      emit(DeleteDataSuccessStates());
    }).catchError((onError){
      emit(DeleteDataErrorStates());
      print(onError.toString());
    });
  }
}