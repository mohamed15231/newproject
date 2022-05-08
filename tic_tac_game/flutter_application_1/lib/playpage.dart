import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai.dart';
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
      backgroundColor:  Colors.grey,
      body: SafeArea(
          child: Column(
        children: [
          SwitchListTile.adaptive(
            title:  Text(
              isSwitch ? "Two player": "One player",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            activeColor: Colors.black,
            value: isSwitch,
            onChanged: (val) {
              setState(() {
                isSwitch = val;
              });
              activePlayer = "X";
              gameOver = false;
              turn = 0;
              result = " ";
              player.playerX = [];
              player.playerO = [];
              player.playerOMax=[];
              player.playerXMax=[];


            },
          ),


          Text(
            "Player $activePlayer "
            ,
            style: const TextStyle(
              color: Colors.black,
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
                              : () =>addElement(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
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
                                      ? Colors.white
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
                player.playerOMax=[];
                player.playerXMax=[];
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text("Replay the game"),
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.all(Colors.black),
            ),
            
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
                player.playerOMax=[];
                player.playerXMax=[];
              });
              Navigator.of(ctx).pop();
            },
            child: const Text("replay"),
          ),
        ],
      ),
    );
  }

  addElement(int index) async{

  turn++;
  await game.play(index, activePlayer);
  setState(() {
    activePlayer = activePlayer == "X" ? "O" : "X";
  });

  if(isSwitch==false&& gameOver==false){
    turn++;

   await Autoplay.breadth_first_Search(-2, 0 );
   //  await Autoplay.Depth_first_Search(-2,0);
    setState(() {
      activePlayer = activePlayer == "X" ? "O" : "X";
    });
  }







    result = game.checkWinner(player.playerX,player.playerO);


    if (result == "player O is Winner" || result == "player X is Winner"||result == "tie") {
      setState(() {
        gameOver = true;
      });
    }
    if (gameOver) {
      showdialog();
    }

  }

}
