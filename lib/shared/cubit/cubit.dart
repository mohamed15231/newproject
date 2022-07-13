import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/shared/cubit/states.dart';

import '../../modules/archive/archive_screen.dart';
import '../../modules/done/done_screen.dart';
import '../../modules/new tasks/tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(InitialState());
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];

  static AppCubit get(context)=> BlocProvider.of(context);

  List<Widget> screen = [
    const TasksScreen(),
    const DoneScreen(),
    const ArchiveScreen(),
  ];

  List<String> title = [
    "New Tasks",
    "New Done",
    "New Archive",
  ];
  late Database dataBase;
  bool isShowButtonSheet = false;


  void createDateBase()  {
    emit(LoadingGetDataBase());
      openDatabase(
      "todo.db",
      version: 1,
      onCreate: (dataBase, version) {
        dataBase
            .execute(
            "CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT ,status TEXT)")
            .then((value) {
          print("DataBase Created");
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (dataBase) {
        getDataFromDataBase(dataBase);
        print("dataBase opened");
      },
    ).then((value) {
      dataBase=value;
      emit(CreateDataBase());
     });
  }

  void insertDataBase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await dataBase.transaction((txn) async {
      txn
          .rawInsert(
        "INSERT INTO tasks(title,date,time,status)VALUES('$title','$date','$time','new')",
      )
          .then((value) {
        print("$value insert database successfully");
        emit(InsertDataBase());
        getDataFromDataBase(dataBase);
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  void getDataFromDataBase(Database dataBase) {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(LoadingGetDataBase());
     dataBase.rawQuery("SELECT * FROM tasks").then((value)
     {
       for (var element in value) {
         if(element['status']=='new') {
           newTasks.add(element);
           print(newTasks);
         } else if(element['status']=='done') {
           doneTasks.add(element);
           print(doneTasks);

         } else {
           archiveTasks.add(element);
           print(archiveTasks);
         }
       }



       emit(GetDataBase());

     });
  }
  int cureentIndex = 0;
  void changeBottomNavBar(int index){
    cureentIndex=index;
    emit(ChangeBottomNavBar());
  }
  void changeBottomSheet({
  required bool isShow
}){
     isShowButtonSheet =isShow;
     emit(ChangeBottomSheet());
  }

  void updateDataBase({
  required String status,
    required int id,
}){
     dataBase.rawUpdate(
        'UPDATE tasks SET status= ? WHERE id = ?',
        [status,id]).then((value) {
          getDataFromDataBase(dataBase);
          emit(UpdateDataBase());
     });

  }

  void deleteDataInDataBase({
  required int id
}){
    dataBase.rawDelete(
      'DELETE FROM tasks WHERE id = ?',[ id ]
    ).then((value) {
      getDataFromDataBase(dataBase);
      emit(DeleteDataFromDataBase());
    });
  }
}