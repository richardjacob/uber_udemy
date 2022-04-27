import 'dart:async';

import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 5), () async {
      //send user to home screen

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => SignUpScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo1.png'),
              const SizedBox(height: 10),
              const Text(
                "Lance App",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
