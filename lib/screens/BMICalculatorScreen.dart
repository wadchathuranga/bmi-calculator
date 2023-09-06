import 'package:bmicalculator/screens/BMICalculatorResultScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import '../utils/app_colors.dart';
import '../widgets/IconWithLabel.dart';
import '../widgets/ReusableCard.dart';

enum GenderSelection { Male, Female }

class BMICalculationScreen extends StatefulWidget {
  const BMICalculationScreen({Key? key}) : super(key: key);

  @override
  State<BMICalculationScreen> createState() => _BMICalculationScreenState();
}

class _BMICalculationScreenState extends State<BMICalculationScreen> {

  final activeColor = Colors.lightBlueAccent;
  late GenderSelection gender = GenderSelection.Male;

  final List<String> units = ['Standard'];
  late String selectedUnit = 'Standard';

  late DateTime date;
  String? _date;

  late int age = 25;

  late double _weight = 50.0;
  late double _height = 150.0;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    _date = DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        // actions: [ // TODO: Future Implement
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.settings),
        //   ),
        //   const SizedBox(width: 10),
        // ],
      ),
      body: WillPopScope(
        onWillPop: () => popped(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: gender == GenderSelection.Male
                                  ? AppColors.numberPicker
                                  : Colors.transparent,
                            ),
                          ),
                          child: const IconWithLabel(
                            icon: FontAwesomeIcons.mars,
                            label: 'MALE',
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            gender = GenderSelection.Male;
                          });
                        },
                      ),
                    ),
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: gender == GenderSelection.Male
                                  ? Colors.transparent
                                  : AppColors.numberPicker,
                            ),
                          ),
                          child: const IconWithLabel(
                            icon: FontAwesomeIcons.venus,
                            label: 'FEMALE',
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            gender = GenderSelection.Female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'DATE',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.numberPicker),
                                ),
                                child: Text(
                                  _date.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.numberPicker,
                                  ),
                                ),
                              ),
                              onTap: () => pickDate(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'UNITS',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                style: const TextStyle(color: AppColors.numberPicker),
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: units
                                    .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // color: AppColors.numberPicker,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedUnit,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedUnit = value!;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.numberPicker,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'HEIGHT',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'cm',
                                ),
                                Text(
                                  'mm',
                                ),
                              ],
                            ),
                          ),
                          DecimalNumberPicker(
                            itemWidth: 40,
                            itemHeight: 45,
                            value: _height,
                            minValue: 0,
                            maxValue: 250,
                            decimalPlaces: 1,
                            onChanged: (value) => setState(() => _height = value),
                            selectedTextStyle: const TextStyle(
                              fontSize: 20,
                              color: AppColors.numberPicker,
                            ),
                            integerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.numberPicker),
                            ),
                            decimalDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.numberPicker),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'years',
                          ),
                          NumberPicker(
                            itemHeight: 45,
                            itemWidth: 50,
                            value: age,
                            minValue: 0,
                            maxValue: 100,
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() => age = value),
                            selectedTextStyle: const TextStyle(
                              fontSize: 20,
                              color: AppColors.numberPicker,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.numberPicker),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableCard(
                      color: const Color(0xff1d1e33),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'WEIGHT',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'kg',
                                ),
                                Text(
                                  'g',
                                ),
                              ],
                            ),
                          ),
                          DecimalNumberPicker(
                            itemWidth: 40,
                            itemHeight: 45,
                            value: _weight,
                            minValue: 0,
                            maxValue: 250,
                            decimalPlaces: 1,
                            onChanged: (value) => setState(() => _weight = value),
                            selectedTextStyle: const TextStyle(
                              fontSize: 20,
                              color: AppColors.numberPicker,
                            ),
                            integerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.numberPicker),
                            ),
                            decimalDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.numberPicker),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2.0, top: 2.5),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => BMICalculatorResultScreen(
                                  height: _height,
                                  weight: _weight,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: AppColors.numberPicker,
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Calculate BMI', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDate() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() {
      date = newDate;
      _date = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  //double tap to exit
  DateTime current = DateTime.now().subtract(const Duration(milliseconds: 1500));
  Future<bool> popped() {
    DateTime now = DateTime.now();
      if (now.difference(current) > const Duration(milliseconds: 1500)){
        current = now;
        Fluttertoast.showToast(
            msg: "Press Again to Exit!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return Future.value(false);
      } else{
        Fluttertoast.cancel();
        return Future.value(true);
      }
  }

}




