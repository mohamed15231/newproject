import 'package:bank/context.dart';
import 'package:bank/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final Color color;
  final String image;
  final int number;
  final String valid;
  const CreditCard(this.color, this.image, this.number, this.valid, {Key? key}) : super(key: key);
  // const Color.fromRGBO(42, 18, 20, 1)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
            color:color ,
            borderRadius: BorderRadius.circular(25),
            boxShadow:  const [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3,7),
                  blurRadius: 20
              )
            ]

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,top: 15.0),
                  child: Image.asset(
                    "assets/images/$image",
                    width: 50.0,
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text:  TextSpan(children: [
                     TextSpan(
                      text: "${AppCubit.get(context).tasks[indexofelement]["name"]} \n ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: " ${AppCubit.get(context).tasks[indexofelement]["numofcard"]} \n ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                     TextSpan(
                      text: valid,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
