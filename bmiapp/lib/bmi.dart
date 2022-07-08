import 'dart:math';

import 'package:bmiapp/resultofbmi.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BmiScreenState();
}

class _BmiScreenState extends State {
   double sliderValue=160;
   int ageValue=20;
   int weightValue=60;
   bool isMale=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Center(
          child: Text("Bmi"),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            isMale=true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: !isMale ? Colors.grey:Colors.blue
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.male,
                                size: 100.0,
                                color: Colors.white,
                              ),
                              Text(
                                "male",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            isMale=false;
                          });

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: isMale ? Colors.grey:Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:   const [
                              Icon(
                                Icons.female,
                                size: 100.0,
                                color: Colors.white,
                              ),



                              Text(
                                "female",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Container(
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text(
                        "HEIGHT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline:TextBaseline.alphabetic ,
                        children:  [
                          Text(
                            "${sliderValue.round()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 50
                            ),
                          ),
                          const Text(
                            "cm",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                      Slider(
                          value: sliderValue,
                          onChanged: (value)
                          {
                            setState(() {
                              sliderValue=value;
                            });

                          },
                          min:0,
                          max:200,

                      ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(

                  children: [
                    Expanded(
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children:  [
                            const Text(
                              "WEIGHT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                             Text(
                              "$weightValue",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {

                                      --weightValue;
                                    });

                                  },
                                  child: const Icon(
                                    Icons.remove,
                                  ),
                                  mini: true,

                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      ++weightValue;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                  mini: true,

                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text(
                              "AGE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                             Text(
                              "$ageValue",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      --ageValue;
                                    });

                                  },
                                  child: const Icon(
                                    Icons.remove,
                                  ),
                                  mini: true,

                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      ++ageValue;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                  mini: true,

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
            MaterialButton(
              color: Colors.red,
                height: 50,
                onPressed: () {
                double result= weightValue/pow(sliderValue/100,2) ;

                Navigator.of(context).push(
                 MaterialPageRoute(builder: (context)=> ResultBmi(
                   age: ageValue,
                   isMale: isMale,
                   result:result ,
                 ))
                );

                },
                child: const Center(
                  child: Text("CALCULATOR"),
                )),
          ],
        ),
      ),
    );
  }
}
