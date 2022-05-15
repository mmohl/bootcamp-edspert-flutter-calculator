import 'package:bmi_calculator/constants/global.dart';
import 'package:bmi_calculator/views/bmi_data_screen.dart';
import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  const BmiResultScreen(
      {Key? key,
      required this.resultValue,
      required this.resultCategory,
      required this.resultRisk})
      : super(key: key);
  final double resultValue;
  final String resultCategory;
  final String resultRisk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI CALCULATION RESULT')),
      body: Column(
        children: [
          const Text(
            'Result',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Expanded(
              flex: 5,
              child: BmiCard(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          resultCategory.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$resultValue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          resultRisk,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              )),
          GestureDetector(
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BmiDataScreen()))
            },
            child: Container(
              color: secondayColor,
              height: 60,
              child: const Center(
                  child: Text(
                'RECALCULATE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
