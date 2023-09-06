import 'package:bmicalculator/utils/app_colors.dart';
import 'package:bmicalculator/widgets/ReusableCard.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../widgets/BMICategory.dart';

class BMICalculatorResultScreen extends StatefulWidget {
  const BMICalculatorResultScreen({Key? key, required this.height, required this.weight}) : super(key: key);

  final double height;
  final double weight;

  @override
  State<BMICalculatorResultScreen> createState() => _BMICalculatorResultScreenState();
}

class _BMICalculatorResultScreenState extends State<BMICalculatorResultScreen> {

  final bool isActive = true;

  late double BMI = 0.0;

  final List<Map<String, dynamic>> category = [
    {"title":"Underweight", "value":"BMI < 18.5", "color": Colors.redAccent, "isActive": false},
    {"title":"Normal", "value":"18.5 <= BMI < 25.0", "color": Colors.green, "isActive": false},
    {"title":"Pre-obesity", "value":"25.0 <= BMI < 30.0", "color": Colors.yellow, "isActive": false},
    {"title":"Obesity class I", "value":"30.0 <= BMI < 35.0", "color": Colors.orange, "isActive": false},
    {"title":"Obesity class II", "value":"35.0 <= BMI < 40.0", "color": Colors.redAccent, "isActive": false},
    {"title":"Obesity class III", "value":"40.0 <= BMI", "color": Colors.red, "isActive": false},
  ];

  @override
  void initState() {
    super.initState();
    calculateBMI();
  }

  void calculateBMI() {
    setState(() {
      BMI = widget.weight / ((widget.height/100) * (widget.height/100));
      if (BMI < 18.5) {
        category[0]["isActive"] = true;
      } else if (18.5 <= BMI && BMI < 25.0) {
        category[1]["isActive"] = true;
      } else if (25.0 <= BMI && BMI < 30.0) {
        category[2]["isActive"] = true;
      } else if (30.0 <= BMI && BMI < 35.0) {
        category[3]["isActive"] = true;
      } else if (35.0 <= BMI && BMI < 40.0) {
        category[4]["isActive"] = true;
      } else if (40.0 <= BMI) {
        category[5]["isActive"] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Results'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReusableCard(
            color: const Color(0xff1d1e33),
            cardChild: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 230,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        showLabels: false,
                        showTicks: false,
                        startAngle: 180,
                        endAngle: 0,
                        canScaleToFit: true,
                        minimum: 10,
                        maximum: 50,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.3,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            enableAnimation: true,
                            animationDuration: 1000,
                            animationType: AnimationType.ease,
                            value: BMI,
                            needleLength: 0.9,
                            needleColor: AppColors.numberPicker,
                            knobStyle: const KnobStyle(
                              knobRadius: 0.08,
                              sizeUnit: GaugeSizeUnit.factor,
                              color: AppColors.numberPicker,
                            ),
                          ),
                        ],
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 10,endValue: 18.5,color: Colors.redAccent,startWidth: 30,endWidth: 30),
                          GaugeRange(startValue: 18.5,endValue: 24.9,color: Colors.green,startWidth: 30,endWidth: 30),
                          GaugeRange(startValue: 24.9,endValue: 29.9,color: Colors.yellow,startWidth: 30,endWidth: 30),
                          GaugeRange(startValue: 29.9,endValue: 34.9,color: Colors.orange,startWidth: 30,endWidth: 30),
                          GaugeRange(startValue: 34.9,endValue: 39.9,color: Colors.redAccent,startWidth: 30,endWidth: 30),
                          GaugeRange(startValue: 39.9,endValue: 50.0,color: Colors.red,startWidth: 30,endWidth: 30),
                        ],
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      border: Border.all(
                        width: 2,
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'HEIGHT',
                                style: TextStyle(
                                  // color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.height.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.numberPicker
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'WEIGHT',
                                style: TextStyle(
                                  // color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.weight.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.numberPicker
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.numberPicker,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'BMI',
                                      style: TextStyle(
                                        // color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      BMI.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ReusableCard(
            color: const Color(0xff1d1e33),
            cardChild: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'BMI CATEGORY',
                      style: TextStyle(
                        // color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  if (BMI != 0.0)
                    ListView.builder(
                    shrinkWrap: true,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return BMICategory(isActive: category[index]["isActive"], title: category[index]["title"], value: category[index]["value"], color: category[index]["color"],);
                    },
                  )
                  else
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
