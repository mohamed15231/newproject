import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/game.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  _playPage createState() => _playPage();
}

// ignore: camel_case_types
class _playPage extends State {
  bool isSwitch = true;
  String activePlayer = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00002e63),
      body: SafeArea(
          child: Column(
        children: [
          SwitchListTile.adaptive(
            title: const Text(
              "on/off two player",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            value: isSwitch,
            onChanged: (val) {
              setState(() {
                isSwitch = val;
              });
            },
          ),
          Text(
            "It's $activePlayer turn ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                children: List.generate(
                    9,
                    (index) => InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: gameOver ||
                                  player.playerX.contains(index) ||
                                  player.playerO.contains(index)
                              ? null
                              : () => addElement(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                player.playerX.contains(index)
                                    ? "X"
                                    : player.playerO.contains(index)
                                        ? "O"
                                        : "",
                                style: TextStyle(
                                  fontSize: 60.0,
                                  fontWeight: FontWeight.bold,
                                  color: player.playerX.contains(index)
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                activePlayer = "X";
                gameOver = false;
                turn = 0;
                result = " ";
                player.playerX = [];
                player.playerO = [];
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text("Replay the game"),
          )
        ],
      )),
    );
  }

  showdialog() {
    setState(() {});
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Result"),
        content: Text(result),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("okay"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
            ),
            onPressed: () {
              setState(() {
                activePlayer = "X";
                gameOver = false;
                turn = 0;
                result = " ";
                player.playerX = [];
                player.playerO = [];
              });
              Navigator.of(ctx).pop();
            },
            child: const Text("replay"),
          ),
        ],
      ),
    );
  }

  addElement(int index) {
    turn++;
    game.play(index, activePlayer);
    setState(() {
      activePlayer = activePlayer == "X" ? "O" : "X";
    });
    result = game.checkWinner();
    if (turn == 9) {
      setState(() {
        gameOver = true;
      });
      result = "Draw !";
    }

    if (result == "player O is Winner" || result == "player X is Winner") {
      setState(() {
        gameOver = true;
      });
    }
    if (gameOver) {
      showdialog();
    }
  }
}
