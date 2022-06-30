import 'package:bank/context.dart';
import 'package:bank/packages/package.dart';
import 'package:bank/project.dart';
import 'package:flutter/material.dart';

import 'cubit/cubit.dart';

class SignUp extends StatefulWidget {
  final void Function(
    String email,
    String password,
    bool islogin,
    String username,
    String numbercard,
    BuildContext ctx,
  ) authScreen;

  // bool isloading;

  SignUp(this.authScreen);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var cardscontroller = TextEditingController();


  bool islogin = true;
  String email = "";
  String password = "";
  String username = "";
  final formKey = GlobalKey<FormState>();
  bool show = true;

  void sginUp() {
    FocusScope.of(context).unfocus();

    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      widget.authScreen(email.trim(), password.trim(), islogin, username.trim(),
          cardscontroller.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(islogin ? "Log In" : "Sign up"),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "M A Z H",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //User name
                                if (!islogin)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "User name",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      TextFormField(
                                        key: const ValueKey("username"),
                                        validator: (value) {
                                          if (value.toString().isEmpty ||
                                              value!.length < 5) {
                                            return "Please Enter the user name";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          username = value!;
                                        },
                                        style: const TextStyle(fontSize: 25.0),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3, color: Colors.grey),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ],
                                  ),

                                const SizedBox(
                                  height: 20.0,
                                ),
                                //number of card
                                if (!islogin)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Number card",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      TextFormField(
                                        key: const ValueKey("numbercard"),
                                        controller: cardscontroller,
                                        validator: (value) {
                                          setState(() {});

                                          if (cardscontroller.text.length !=
                                              16||!AppCubit.get(context).search(AppCubit.get(context).tasks, int.parse(cardscontroller.text.toString()))) {
                                            return "Please Enter the valid number";
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(fontSize: 25.0),
                                        decoration: const InputDecoration(
                                          hintText: "**** **** **** ****",
                                          prefixIcon: Icon(Icons.credit_card),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3, color: Colors.grey),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 20.0,
                                ),

                                //email
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    TextFormField(
                                      key: const ValueKey("email"),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return "Please Enter the valid email";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        email = value!;
                                      },
                                      style: const TextStyle(fontSize: 25.0),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.grey),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 20.0,
                                ),

                                //password
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    formfield(
                                      key: const ValueKey("password"),
                                      show: show,
                                      prfixicon: const Icon(Icons.lock_outline),
                                      suffixicon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.remove_red_eye_outlined),
                                      ),
                                      save: (newValue) {
                                        setState(() {
                                          password = newValue!;
                                        });
                                      },
                                      valid: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 8) {
                                          return "Your password not right";
                                        }
                                        return null;
                                      },
                                      typeKeyboard:
                                          TextInputType.visiblePassword,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // if (widget.isloading)
                              //   const CircularProgressIndicator(),
                              // if (!widget.isloading)
                              ElevatedButton(
                                onPressed: sginUp,
                                child: Text(islogin ? "Login" : "Signup"),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    islogin = !islogin;
                                  });
                                },
                                child: Text(!islogin ? "Login" : "Signup"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
