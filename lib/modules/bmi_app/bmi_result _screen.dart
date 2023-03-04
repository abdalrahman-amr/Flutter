import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIResult extends StatelessWidget {

  final int age ;
  final bool isMale;
  final String result;

  BMIResult({
    required this.result,
    required this.isMale,
    required this.age,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Gender: ${isMale? "Male":"Female"}",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold

              ),),
            Text('Result: $result',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold

            )),
            Text("Age: $age",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold

            )),
          ],
        ),
      ),
    );
  }
}


