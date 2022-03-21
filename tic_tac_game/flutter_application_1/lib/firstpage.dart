import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/playpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/images/tic-tac-toe-two-player-board-games.jpg"),
      logoSize: 180.0,
      navigator: const PlayPage(),
      backgroundColor: Colors.black,
      loaderColor: Colors.blue,
      durationInSeconds: 5,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
      title: const Text(
        "Tic_Tac_game...",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
