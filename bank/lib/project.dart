import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:bank/context.dart';
import 'package:bank/cubit/cubit.dart';
import 'package:bank/cubit/status.dart';
import 'package:bank/packages/card.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sqflite/sqflite.dart';
// state is==AppGetLoadingDataBaseStates?
// const Center(
// child: CircularProgressIndicator(
//
//
// ),
// ):
class HomeBank extends StatelessWidget {
  const HomeBank({Key? key}) : super(key: key);


  @override
  @override
  Widget build(BuildContext context) {




    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(

            backgroundColor: const Color.fromRGBO(96, 40, 46, 1),
            elevation: 0.0,
            title: Text(AppCubit.get(context)
                .tasks[indexofelement]["name"]
                .toString()),
            actions: [
              DropdownButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("Logout"),
                        ],
                      ),
                      value: "Logout",
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == "Logout") {
                      FirebaseAuth.instance.signOut();
                    }
                  })
            ],
          ),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(96, 40, 46, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                text: "\n Total balance \n",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 18.0),
                              ),
                              const TextSpan(
                                text: "\n \$",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 30.0),
                              ),
                              TextSpan(
                                text:
                                " ${AppCubit.get(context).tasks[indexofelement]["balance"]} \n",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                              const TextSpan(
                                text: "\n Your cards ",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 20.0),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          CreditCard(Color.fromRGBO(42, 18, 20, 1),
                              "Mastercard1.png", 1234, "VALID 19/22"),
                          CreditCard(Color.fromRGBO(0, 0, 204, 1),
                              "visacard.png", 1234, "VALID 07/24"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Send money",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) => SingleChildScrollView(
                                    child: Container(
                                      width: double.infinity,
                                      height: 500,
                                      child: Form(
                                        key: AppCubit.get(context).formkey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  const Text(
                                                    "Number card",
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    key: const ValueKey(
                                                        "numbercard"),
                                                    controller: AppCubit
                                                        .get(context)
                                                        .numcardcontroller,
                                                    validator: (value) {
                                                      if (AppCubit.get(
                                                          context)
                                                          .numcardcontroller
                                                          .text
                                                          .length !=
                                                          16 ||
                                                          !AppCubit.get(context).search(
                                                              AppCubit.get(
                                                                  context)
                                                                  .tasks,
                                                              int.parse(AppCubit
                                                                  .get(
                                                                  context)
                                                                  .numcardcontroller
                                                                  .text
                                                                  .toString()))) {
                                                        return "Please Enter the valid number";
                                                      }
                                                      return null;
                                                    },
                                                    style: const TextStyle(
                                                        fontSize: 25.0),
                                                    decoration:
                                                    const InputDecoration(
                                                      hintText:
                                                      "**** **** **** ****",
                                                      prefixIcon: Icon(Icons
                                                          .credit_card),
                                                      filled: true,
                                                      fillColor:
                                                      Colors.white,
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                            width: 3,
                                                            color: Colors
                                                                .grey),
                                                      ),
                                                    ),
                                                    keyboardType:
                                                    TextInputType
                                                        .number,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  const Text(
                                                    "money",
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller: AppCubit
                                                        .get(context)
                                                        .moneycontroller,
                                                    validator: (value) {
                                                      if (int.parse(AppCubit
                                                          .get(
                                                          context)
                                                          .moneycontroller
                                                          .text
                                                          .toString()) >
                                                          AppCubit.get(context)
                                                              .tasks[
                                                          indexofelement]
                                                          [
                                                          "balance"] ||
                                                          value
                                                              .toString()
                                                              .isEmpty) {
                                                        return "Amount exceeded balance";
                                                      }
                                                      return null;
                                                    },
                                                    style: const TextStyle(
                                                        fontSize: 25.0),
                                                    decoration:
                                                    const InputDecoration(
                                                      prefixIcon: Icon(Icons
                                                          .attach_money),
                                                      filled: true,
                                                      fillColor:
                                                      Colors.white,
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                            width: 3,
                                                            color: Colors
                                                                .grey),
                                                      ),
                                                    ),
                                                    keyboardType:
                                                    TextInputType
                                                        .number,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  AppCubit.get(context)
                                                      .sendMoney(context);
                                                },
                                                child: const Text(
                                                    "Send money"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor:
                            const Color.fromRGBO(153, 0, 0, 1),
                            radius: 25.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}
