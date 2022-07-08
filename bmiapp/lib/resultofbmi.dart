
import 'package:flutter/material.dart';

class ResultBmi extends StatelessWidget{
  final bool isMale;
  final double result;
  final int age;
    ResultBmi({Key? key,
    required this.isMale,
    required this.result,
    required this.age}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    String resultWeightValue=resultWeight();
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Center(
          child: Text(
            "Bmi Result"
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey
          ),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                "Gender:${isMale ? "Male":"Female"}",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Result:${result.round()}",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Age:$age",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Weight Status:$resultWeightValue",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String resultWeight(){
    late String weightStatus;

    if(result.round()<=18 ){
      weightStatus="Under weight";
    }
    else if(result.round()>18 && result.round()<=24){
      weightStatus="Healthy";
    }
    else if(result.round()>24 && result.round()<=29){
      weightStatus ="Over weight";
    }else{
      weightStatus="obese";
    }
    return weightStatus;
  }

}