import 'package:flutter_application_1/game.dart';

class Autoplay{

   static late int index2;





   static Future<int> children(int depth, bool isMaximizing, {bool isfirst = true}) async
   {

     if (player.playerO.contains(1) & player.playerO.contains(4) && !player.playerX.contains(7) ) {
       game.play(7, "O");
     }
     int result;

     late int index;
     if (game.checkWinner(player.playerXMax, player.playerOMax) ==
         "player X is Winner") {
       result = 2;
     } else if (game.checkWinner(player.playerXMax, player.playerOMax) ==
         "player O is Winner") {
       result = -2;
     } else if (game.checkWinner(player.playerXMax, player.playerOMax) =="tie") {
       result = 0;
     } else {
       result = 1;
     }

     if (result != 1 || depth == 0) {
       return result;
     }
     if (isMaximizing) {
       int finalScore = -150;
       for (int i = 0; i < 9; i++) {
         if (!(player.playerOMax.contains(i) || player.playerXMax.contains(i))) {
           player.playerXMax.add(i);

           int score = await children(depth - 1, false, isfirst: false);

           player.playerXMax.removeLast();


           if (score > finalScore) {
             finalScore = score;
           }


         }
       }
       return finalScore;
     }
     else {
       int finalScore = 150;
       for (int i = 0; i < 9; i++) {
         if (!(player.playerOMax.contains(i) || player.playerXMax.contains(i))) {
           player.playerOMax.add(i);

           int score = await children(depth - 1, true, isfirst: false);

           player.playerOMax.removeLast();

           if (score < finalScore) {

             finalScore = score;


             index=i;

           }

         }
       }
       if(isfirst){
         index2=index;

       }
       return finalScore;
     }
   }
   static Future<void> breadth_first_Search(int goal,int goal1) async
   {
    List queue =[];
    int initialstate=await children(100, false,isfirst: true);
    queue.add(initialstate);
    while(queue.isNotEmpty){
      int currentstate=queue[0];
      queue.removeAt(0);
      if(currentstate ==goal){
        game.play(index2, "O");
        break;
      }
      else if(currentstate ==goal1){
        game.play(index2, "O");
        break;
      }else{
        currentstate=await children(100, false,isfirst: true);
      }
    }


  }
   static Future<void> Depth_first_Search(int goal,int goal1) async
   {
     List stack =[];
     int initialstate=await children(100, false,isfirst: true);
     stack.add(initialstate);
     while(stack.isNotEmpty){
       int currentstate=stack[0];

       stack.removeAt(stack.length-1);
       if(currentstate ==goal){
         game.play(index2, "O");
         break;
       }
       else if(currentstate ==goal1){
         game.play(index2, "O");
         break;
       }else{
         currentstate=await children(100, false,isfirst: true);
       }
     }


   }



}