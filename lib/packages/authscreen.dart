import 'package:advance_notification/advance_notification.dart';
import 'package:bank/context.dart';
import 'package:bank/cubit/cubit.dart';
import 'package:bank/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen  extends StatefulWidget {
  const AuthScreen ({Key? key}) : super(key: key);

  @override
  State<AuthScreen > createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen > {
  Future getdata(database) async {

    return await database.rawQuery("SELECT * FROM Test");
  }

  final auth=FirebaseAuth.instance;

  void authScreen(String email, String password, bool islogin, String username,String numbercard,
      BuildContext ctx,)async{
    UserCredential authresult;
    try {
      if(islogin==true ){
         authresult = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        );
      }else {




          authresult = await auth.createUserWithEmailAndPassword(
              email: email,
              password: password
          );
          FirebaseFirestore.instance.collection("users").doc(authresult.user!.uid).set({
            "username":username,
            "email":email,
            "password":password,
            "numbercard":numbercard,

          });
          indexofelement = AppCubit.get(context).index(AppCubit.get(context).tasks, int.parse(numbercard.toString()));




      }
    } on FirebaseAuthException catch (e) {
      String massege =" ";
      if (e.code == 'weak-password') {
        const AdvanceSnackBar(
            message: 'The password provided is too weak.',
            bgColor: Colors.blueAccent).show(context);
      } else if (e.code == 'email-already-in-use') {
        const AdvanceSnackBar(
            message: 'The account already exists for that email.',
            bgColor: Colors.blueAccent).show(context);

      }else if (e.code == 'user-not-found') {
        const AdvanceSnackBar(
            message: 'No user found for that email.',
            bgColor: Colors.blueAccent).show(context);

      } else if (e.code == 'wrong-password') {
        const AdvanceSnackBar(
            message: 'Wrong password provided for that user.',
            bgColor: Colors.blueAccent).show(context);

      }



    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUp(authScreen),
    );
  }
}
