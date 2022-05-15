import 'dart:math';

import 'package:bmi_calculator/views/bmi_result_screen.dart';
import 'package:bmi_calculator/constants/global.dart';
import 'package:flutter/material.dart';

class BmiDataScreen extends StatefulWidget {
  const BmiDataScreen({Key? key}) : super(key: key);

  @override
  State<BmiDataScreen> createState() => _BmiDataScreenState();
}

class _BmiDataScreenState extends State<BmiDataScreen> {
  double inputHeight = 100;
  int inputWeight = 50;
  int inputAge = 20;

  double calculateBMI() {
    double inputHeightInMeter = inputHeight / 100;
    double result = inputWeight / pow(inputHeightInMeter, 2);

    return result.roundToDouble();
  }

  String getBMICategory() {
    double bmiResult = calculateBMI();
    String resultCategory = '';

    if (bmiResult < 16.0) {
      resultCategory = bodyCategoryUnderweightThinnesSevere;
    } else if (bmiResult < 16.9) {
      resultCategory = bodyCategoryUnderweightThinnesModerate;
    } else if (bmiResult < 18.4) {
      resultCategory = bodyCategoryUnderweightThinnesMild;
    } else if (bmiResult < 24.9) {
      resultCategory = bodyCategoryNormal;
    } else if (bmiResult < 29.9) {
      resultCategory = bodyCategoryOverweight;
    } else if (bmiResult < 34.9) {
      resultCategory = bodyCategoryObeseClass1;
    } else if (bmiResult < 39.9) {
      resultCategory = bodyCategoryObeseClass2;
    } else if (bmiResult >= 40.0) {
      resultCategory = bodyCategoryObeseClass3;
    }

    return resultCategory;
  }

  String getBMIHealtyRisk() {
    String bmiCategory = getBMICategory();

    switch (bmiCategory) {
      case bodyCategoryUnderweightThinnesSevere:
        return 'Need to eat a lot';
      case bodyCategoryUnderweightThinnesModerate:
        return 'Need to eat a lot';
      case bodyCategoryUnderweightThinnesMild:
        return 'You\'re almost good, gain a bit more if you want to get normal body mass.';
      case bodyCategoryNormal:
        return 'You\'ve ideal body mass.';
      case bodyCategoryOverweight:
        return 'You\'re fat, better do exercise.';
      case bodyCategoryObeseClass1:
        return 'You\'re obese, do exercise and eat more healthy foods';
      case bodyCategoryObeseClass2:
        return 'You\'re obese, do exercise and eat more healthy foods';
      case bodyCategoryObeseClass3:
        return 'You\'re obese, do exercise and eat more healthy foods';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0e21),
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Column(children: [
        Expanded(
            child: Row(children: const [
          Expanded(
            child: BmiCard(
              child: GenderIconText(
                label: 'Male',
                icon: Icons.male,
              ),
            ),
          ),
          Expanded(
            child: BmiCard(
              child: GenderIconText(
                label: 'Female',
                icon: Icons.female,
              ),
            ),
          ),
        ])),
        Expanded(
            child: BmiCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Height',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$inputHeight",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                  const Text(
                    'cm',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Slider(
                  thumbColor: secondayColor,
                  activeColor: Colors.white,
                  value: inputHeight,
                  onChanged: (value) {
                    inputHeight = value.roundToDouble();
                    setState(() {});
                  },
                  min: 80,
                  max: 200)
            ],
          ),
        )),
        Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: BmiIncrementalButton(
            label: 'weight',
            defaultValue: inputWeight,
            onPressedIncrease: () {
              setState(() {
                inputWeight++;
              });
            },
            onPressedDecrease: () {
              setState(() {
                inputWeight--;
              });
            },
          )),
          Expanded(
              child: BmiIncrementalButton(
            label: 'age',
            defaultValue: inputAge,
            onPressedDecrease: () {
              setState(() {
                inputAge--;
              });
            },
            onPressedIncrease: () {
              setState(() {
                inputAge++;
              });
            },
          ))
        ])),
        GestureDetector(
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BmiResultScreen(
                      resultValue: calculateBMI(),
                      resultCategory: getBMICategory(),
                      resultRisk: getBMIHealtyRisk(),
                    ))),
          },
          child: Container(
            color: secondayColor,
            height: 60,
            child: const Center(
                child: Text(
              'CALCULATE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
          ),
        )
      ]),
    );
  }
}

class BmiIncrementalButton extends StatelessWidget {
  const BmiIncrementalButton(
      {Key? key,
      required this.label,
      required this.onPressedIncrease,
      required this.onPressedDecrease,
      this.defaultValue})
      : super(key: key);

  final String label;
  final int? defaultValue;
  final int _value = 0;
  final Function onPressedIncrease;
  final Function onPressedDecrease;

  int get value {
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return BmiCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: labelTextStyle,
          ),
          Text(
            (defaultValue ?? 0).toString(),
            style: numberTextStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                child: const Icon(Icons.remove),
                onPressed: () {
                  onPressedDecrease();
                },
                elevation: 0,
                shape: const CircleBorder(),
                fillColor: const Color.fromARGB(83, 158, 157, 158),
                constraints:
                    const BoxConstraints.tightFor(width: 56, height: 56),
              ),
              RawMaterialButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  onPressedIncrease();
                },
                elevation: 0,
                shape: const CircleBorder(),
                fillColor: const Color.fromARGB(83, 158, 157, 158),
                constraints:
                    const BoxConstraints.tightFor(width: 56, height: 56),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GenderIconText extends StatelessWidget {
  const GenderIconText({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
          color: Colors.white,
        ),
        Text(
          label,
          style: labelTextStyle,
        )
      ],
    );
  }
}

class BmiCard extends StatelessWidget {
  const BmiCard({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(83, 158, 157, 158)),
      child: child,
    );
  }
}
