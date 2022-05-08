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
}
