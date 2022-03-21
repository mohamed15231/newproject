// ignore_for_file: duplicate_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/playpage.dart';

// ignore: unused_import
import 'firstpage.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: const SplashPage(),
    );
  }
}
