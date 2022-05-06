import 'dart:ffi';

class player {
  static String o = "O";
  static String x = "X";
  static String empty = " ";

  static List<int> playerX = [];
  static List<int> playerO = [];
  static List<int> playerOMax = [];
  static List<int> playerXMax = [];
}

// ignore: camel_case_types
class game {
  static List<int> empty = [];

  static Future<void> play(int index, String element) async {
    if (element == "X") {
      player.playerX.add(index);
      player.playerXMax.add(index);
    } else {
      player.playerO.add(index);
      player.playerOMax.add(index);
    }
  }

  static String checkWinner(List<int> playerX, List<int> playerO) {
    bool tie=true;
   for(int i=0;i < 9;i++) {
      if (!(playerX.contains(i)||playerO.contains(i))) {
        tie = false;
      }
    }

    if (playerX.contains(0) & playerX.contains(3) & playerX.contains(6)) {
      return "player X is Winner";
    } else if (playerX.contains(0) &
        playerX.contains(1) &
        playerX.contains(2)) {
      return "player X is Winner";
    } else if (playerX.contains(3) &
        playerX.contains(4) &
        playerX.contains(5)) {
      return "player X is Winner";
    } else if (playerX.contains(2) &
        playerX.contains(4) &
        playerX.contains(6)) {
      return "player X is Winner";
    }else if (playerX.contains(0) &
        playerX.contains(4) &
        playerX.contains(8)) {
      return "player X is Winner";
    } else if (playerX.contains(6) &
        playerX.contains(7) &
        playerX.contains(8)) {
      return "player X is Winner";
    } else if (playerX.contains(1) &
        playerX.contains(4) &
        playerX.contains(7)) {
      return "player X is Winner";
    } else if (playerX.contains(2) &
        playerX.contains(5) &
        playerX.contains(8)) {
      return "player X is Winner";
    }
    else if (playerO.contains(0) & playerO.contains(3) & playerO.contains(6)) {
      return "player O is Winner";
    } else if (playerO.contains(0) &
        playerO.contains(1) &
        playerO.contains(2)) {
      return "player O is Winner";
    }

    else if (playerO.contains(3) & playerO.contains(4) & playerO.contains(5)) {
      return "player O is Winner";
    } else if (playerO.contains(6) &
        playerO.contains(7) &
        playerO.contains(8)) {
      return "player O is Winner";
    } else if (playerO.contains(1) &
        playerO.contains(4) &
        playerO.contains(7)) {
      return "player O is Winner";
    }else if (playerO.contains(0) &
        playerO.contains(4) &
        playerO.contains(8)) {
      return "player O is Winner";
    }else if (playerO.contains(2) &
        playerO.contains(4) &
        playerO.contains(6)) {
      return "player O is Winner";
    } else if (playerO.contains(2) &
        playerO.contains(5) &
        playerO.contains(8)) {
      return "player O is Winner";
    }else if(tie){
      return "tie";
    }
    else {
      return "Continue";
    }
  }

  static Future<void> autoplay(activePlayer) async {
    int index = 0;

    for (int i = 0; i < 9; i++) {
      if (!(player.playerX.contains(i) || player.playerO.contains(i))) {
        empty.add(i);
      }
    }
    if (!(empty.contains(0))) {
      index = 5;
    }
    if (!(empty.contains(5))) {
      index = 7;
    }

    play(index, activePlayer);
  }

  static Future<int> minimax(int depth, bool isMaximizing, {bool isfirst = true}) async {
    int result;
    bool empty=false;

    if (checkWinner(player.playerXMax, player.playerOMax) ==
        "player X is Winner") {
      result = 2;
    } else if (checkWinner(player.playerXMax, player.playerOMax) ==
        "player O is Winner") {
      result = -2;
    } else if (checkWinner(player.playerXMax, player.playerOMax) =="tie") {
      result = 0;
    } else {
      result = 1;
    }

    if (result != 1 || depth == 0) {
      return result;
    }
    if (isMaximizing) {
      int finalScore = -10;
      for (int i = 0; i < 9; i++) {
        if (!(player.playerOMax.contains(i) || player.playerXMax.contains(i))) {
          player.playerXMax.add(i);

          int score = await minimax(depth - 1, false, isfirst: false);

           player.playerXMax.removeLast();


          if (score > finalScore) {
            finalScore = score;
          }

          if (isfirst) {
            print("playerO  index= $i socre =$score");
          }
        }
      }
      return finalScore;
    } else {
      int index;
      int finalScore = 10;
      for (int i = 0; i < 9; i++) {
        if (!(player.playerOMax.contains(i) || player.playerXMax.contains(i))) {
          player.playerOMax.add(i);

          int score = await minimax(depth - 1, true, isfirst: false);

           player.playerOMax.removeLast();

          if (score < finalScore) {
            finalScore = score;
            index=i;

          }
          if (isfirst) {
            print("playerO  index= $i socre =$score");
          }
        }
      }
      return finalScore;
    }
  }
}
