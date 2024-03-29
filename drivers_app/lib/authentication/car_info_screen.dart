import 'package:drivers_app/global/constants.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = [
    "Basic Life Support",
    "Advanced Life Support",
    "CCA",
    "Air Ambulance"
  ];

  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child('drivers');
    driversRef
        .child(currentFirebaseUser!.uid)
        .child('car_details')
        .set(driverCarInfoMap);

    Fluttertoast.showToast(msg: 'Vehicle Details have been saved');
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/logo1.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Write your Vehicle Details',
                style: TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(color: kTextColor),
                decoration: const InputDecoration(
                  labelText: 'Vehicle Model',
                  hintText: 'Vehicle Model',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  hintStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                  ),
                ),
              ),
              TextField(
                controller: carNumberTextEditingController,
                style: const TextStyle(color: kTextColor),
                decoration: const InputDecoration(
                  labelText: 'Vehicle Number',
                  hintText: 'Vehicle Number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  hintStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                  ),
                ),
              ),
              TextField(
                controller: carColorTextEditingController,
                style: const TextStyle(color: kTextColor),
                decoration: const InputDecoration(
                  labelText: 'Vehicle Color',
                  hintText: 'Vehicle Color',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton(
                dropdownColor: kBackgroundColor,
                hint: const Text(
                  "Please choose your Ambulance Type",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypesList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(color: kTextColor),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  if (carColorTextEditingController.text.isNotEmpty &&
                      carNumberTextEditingController.text.isNotEmpty &&
                      carModelTextEditingController.text.isNotEmpty &&
                      selectedCarType != null) {
                    saveCarInfo();
                  }
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
                child: const Text(
                  'Save Now',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
