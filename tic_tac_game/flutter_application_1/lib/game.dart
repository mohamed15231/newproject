import 'dart:ffi';

class player {
  static String o = "O";
  static String x = "X";
  static String empty = " ";

  static List<int> playerX = [];
  static List<int> playerO = [];
}

// ignore: camel_case_types
class game {
  static void play(int index, String element) {
    if (element == "X")
      player.playerX.add(index);
    else
      player.playerO.add(index);
  }

  static String checkWinner() {
    if (player.playerX.contains(0) &
        player.playerX.contains(3) &
        player.playerX.contains(6)) {
      return "player X is Winner";
    } else if (player.playerX.contains(0) &
        player.playerX.contains(1) &
        player.playerX.contains(2)) {
      return "player X is Winner";
    } else if (player.playerX.contains(3) &
        player.playerX.contains(4) &
        player.playerX.contains(5)) {
      return "player X is Winner";
    } else if (player.playerX.contains(6) &
        player.playerX.contains(7) &
        player.playerX.contains(8)) {
      return "player X is Winner";
    } else if (player.playerX.contains(1) &
        player.playerX.contains(4) &
        player.playerX.contains(7)) {
      return "player X is Winner";
    } else if (player.playerX.contains(2) &
        player.playerX.contains(5) &
        player.playerX.contains(8)) {
      return "player X is Winner";
    } else if (player.playerX.contains(2) &
        player.playerX.contains(4) &
        player.playerX.contains(6)) {
      return "player X is Winner";
    } else if (player.playerX.contains(0) &
        player.playerX.contains(4) &
        player.playerX.contains(8)) {
      return "player X is Winner";
    } else if (player.playerO.contains(0) &
        player.playerO.contains(3) &
        player.playerO.contains(6)) {
      return "player O is Winner";
    } else if (player.playerO.contains(0) &
        player.playerO.contains(4) &
        player.playerO.contains(8)) {
      return "player O is Winner";
    } else if (player.playerO.contains(0) &
        player.playerO.contains(4) &
        player.playerO.contains(8)) {
      return "player O is Winner";
    } else if (player.playerO.contains(2) &
        player.playerO.contains(4) &
        player.playerO.contains(6)) {
      return "player O is Winner";
    } else if (player.playerO.contains(3) &
        player.playerO.contains(4) &
        player.playerO.contains(5)) {
      return "player O is Winner";
    } else if (player.playerO.contains(6) &
        player.playerO.contains(7) &
        player.playerO.contains(8)) {
      return "player O is Winner";
    } else if (player.playerO.contains(1) &
        player.playerO.contains(4) &
        player.playerO.contains(7)) {
      return "player O is Winner";
    } else if (player.playerO.contains(3) &
        player.playerO.contains(5) &
        player.playerO.contains(8)) {
      return "player O is Winner";
    } else {
      return "Continue";
    }
  }
}
