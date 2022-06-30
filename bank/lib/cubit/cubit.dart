import 'package:bank/context.dart';
import 'package:bank/cubit/status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context)=>BlocProvider.of(context);


  var keyscaffold = GlobalKey<ScaffoldState>();
  var numcardcontroller = TextEditingController();
  var moneycontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();


   static late Database database;
    List<Map> tasks = [];



  int index(List<Map> tasks, var value) {
    int index = 6;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].values.contains(value)) {
        index = i;
      }
    }
    return index;
  }
  bool search(List<Map> tasks, var value) {
    bool mo = false;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].values.contains(value)) {
        mo = true;
      }
    }
    return mo;
  }

  Future transferdata(int value,double balance)async{
    indexoftheacouttranslatehim=index(tasks,value);

    double newbalancecurrentaccount= double.parse(tasks[indexofelement]["balance"].toString())-balance;
    print("your account $newbalancecurrentaccount");
    double newbalancefaraccount=double.parse(tasks[indexoftheacouttranslatehim]["balance"].toString())+ balance;
    print("numofcard $value");
    print("her account $newbalancefaraccount");
    updateDatabase(balance: newbalancefaraccount, numofcard: value);
    updateDatabase(balance: newbalancecurrentaccount, numofcard: tasks[indexofelement]["numofcard"]);
    //
    // await MyAppState.createDatabase();

  }

  void sendMoney(context) {
    if (formkey.currentState!.validate()) {
      Navigator.pop(context);
      transferdata(int.parse(numcardcontroller.text) , double.parse(moneycontroller.text));
      moneycontroller.clear();
      numcardcontroller.clear();
      emit(AppSendMoneyStates());

    }
  }

   void createDatabase()  {
     openDatabase("bank.db", version: 1,
        onCreate: (database, version) {
          print("database created");
          database
              .execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, balance REAL, numofcard INTEGER)')
              .then((value) {
            print("created table");
          }).catchError((error) {
            print("when created table $error");
          });
        }, onOpen: (database) {

          getdata(database);
          print("database opened");
        }).then((value) {
          database =value;
     emit(AppCreateDataBaseStates());
     });
  }

    inserteDataBase({
    required String name,
    required double balance,
    required int numofcard,
  }) async {

     await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO Test(name ,balance,numofcard)VALUES("$name","$balance","$numofcard") ',
      )
          .then((value) {
        print("$value database inserted");
        emit(AppInsertDataBaseStates());
        getdata(database);

      }).catchError((error) {
        print("error in inseart database $error");
      });
    });
  }

  void getdata(Database database)  {
    emit(AppGetLoadingDataBaseStates());
     database.rawQuery("SELECT * FROM Test").then((value) {
       tasks = value;
       print(tasks);
       emit(AppGetDataBaseStates());
     });

  }
  //updatadatabase
   void updateDatabase({required double balance,required int numofcard}) async{
    await database.rawUpdate(
        'UPDATE Test SET balance = ? WHERE numofcard = ?',
        [balance, numofcard]).then((value) {
          getdata(database);
           emit(AppGetUpdateDataBaseStates());



    });
  }


}