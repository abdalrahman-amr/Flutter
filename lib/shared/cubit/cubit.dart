import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/shared/cubit/states.dart';
import 'package:flutter1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../main.dart';
import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  late Database database;
  List<Map> newTasks = []  ;
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  bool isLightMode = true;

  void toggleBrightness({bool ? fromShared}){

    if(fromShared != null){
      isLightMode = fromShared;
    }
    else{
      isLightMode = !isLightMode;

    }

    CacheHelper.saveBoolean(key: "isLightMode", value: isLightMode).then((value)  {
      emit(AppChangeBrightnessModeState());

    });


  }







  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBotNavBarState());
  }
  void createDB() {
    openDatabase(
      'todo1.db',
      version: 1,
      onCreate: (database, version) {
        print("Database Created");
        database
            .execute(
                "CREATE TABLE tasks ( id INTEGER PRIMARY KEY, title TEXT ,date TEXT, time TEXT, status TEXT  )")
            .then((value) {
          print("Table Created");
        }).catchError((error) {
          print("Error when creating table: ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDB(database);
        print("Database Opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  inserttoDB(String title, String date, String time) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertToDBState());
        getDataFromDB(database);
      }).catchError((error) {
        print("Error when Inserting data: ${error.toString()}");
      });
    });
  }

  void getDataFromDB(database)  {
    emit(AppGetFromDBLoadingState());
      database.rawQuery('SELECT * FROM tasks').then((value) {
        newTasks = []  ;
        doneTasks = [];
        archivedTasks = [];

        value.forEach((element){
        if(element["status"] =="new" ){
          newTasks.add(element);
        }
        else if(element["status"] =="done" ){
          doneTasks.add(element);
        }
        else  {
          archivedTasks.add(element);
        }

        });
        emit(AppGetFromDBState());
      });
  }

  void updateData({required int id, required String status}) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDB(database);
      emit(AppUpdateDBState());
    });
  }
  void deleteData({required int id}) async {
    await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value) {
      getDataFromDB(database);
      emit(AppDeleteDBState());
    });
  }


  bool isBottomSheetShown = false;
  IconData addFAB = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    addFAB = icon;
    emit(AppChangeBottomSheet());
  }




}
