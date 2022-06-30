import 'package:bank/context.dart';
import 'package:bank/cubit/cubit.dart';
import 'package:bank/cubit/status.dart';
import 'package:bank/packages/authscreen.dart';
import 'package:bank/project.dart';
import 'package:bank/signup.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'cubit/blocobserver.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {

          },
          builder: (BuildContext context, AppStates state) {
            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.grey,
                backgroundColor: Colors.grey,
              ),
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return const HomeBank();
                  } else {
                    return const AuthScreen();
                  }
                },
              ),
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}
