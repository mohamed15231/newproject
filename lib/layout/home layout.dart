import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/modules/archive/archive_screen.dart';
import 'package:todolist/shared/components/components/components.dart';
import 'package:todolist/shared/components/constant/constant.dart';
import 'package:todolist/shared/cubit/cubit.dart';
import 'package:todolist/shared/cubit/states.dart';

import '../modules/done/done_screen.dart';
import '../modules/new tasks/tasks_screen.dart';

class HomeScreen extends StatelessWidget {





  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..createDateBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, state) =>Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(AppCubit.get(context).title[AppCubit.get(context).cureentIndex]),
            ),
            body:state is LoadingGetDataBase ? const Center(
              child: CircularProgressIndicator(),
            ):AppCubit.get(context).screen[AppCubit.get(context).cureentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (AppCubit.get(context).isShowButtonSheet) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context).insertDataBase(
                      title: titleController.text.toUpperCase(),
                      date: dateController.text,
                      time: timeController.text,
                    );
                  }
                } else {
                  AppCubit.get(context).changeBottomSheet(isShow: true);
                  scaffoldKey.currentState!.showBottomSheet(
                          (context) {
                        return Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defualtTextForm(
                                  controller: titleController,
                                  lable: "Task Title",
                                  iconPrefix: Icons.title,
                                  type: TextInputType.text,
                                  validatefunction: ( value) {
                                    if (value.toString().isEmpty) {
                                      return "please Enter the title";
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(
                                  height: 15.0,
                                ),
                                defualtTextForm(
                                  controller: timeController,
                                  lable: "Task Time",
                                  tap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    }).catchError((error) {
                                      print("error");
                                    });
                                  },
                                  iconPrefix: Icons.watch_later_outlined,
                                  type: TextInputType.number,
                                  validatefunction: (value) {
                                    if (value.toString().isEmpty) {
                                      return "please Enter the Time";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defualtTextForm(
                                  controller: dateController,
                                  lable: "Task Date",
                                  iconPrefix: Icons.calendar_today,
                                  tap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2040)
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    }).catchError((error){
                                      print("no thing");
                                    });
                                  },
                                  type: TextInputType.number,
                                  validatefunction: (value) {
                                    if (value.toString().isEmpty) {
                                      return "please Enter the Date";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).closed.then((value) {
                    AppCubit.get(context).changeBottomSheet(isShow: false);
                  });
                }
              },
              child: Icon(
                AppCubit.get(context).isShowButtonSheet ? Icons.add : Icons.edit,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).cureentIndex,
              onTap: (index) {
                AppCubit.get(context).changeBottomNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: "Archive"),
              ],
            )),
        listener: (BuildContext context, Object? state) {
          if(state is InsertDataBase){
            Navigator.pop(context);
          }

        },

      ),
    );
  }


}


