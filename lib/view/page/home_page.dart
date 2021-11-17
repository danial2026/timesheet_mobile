import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';

import 'login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController userController = UserController();

  static final Map<String, int> monthsInInt = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12
  };
  List<String> dropDownValues = monthsInInt.keys.toList();
  String dropdownValueMonth = monthsInInt.keys.first;
  int dropdownValueDay = 1;

  @override
  Widget build(BuildContext context) {
    User? user = userController.getUserData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                userController.signOutFromGoogle(error: (String error) {
                  Get.snackbar("Error", error);
                }, action: () {
                  Get.offAll(LoginPage());
                });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user!.email ?? ''),
            Text(user.uid),
            user.photoURL != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                    radius: 20,
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: dropdownValueMonth,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueMonth = newValue!;
                    });
                  },
                  items: dropDownValues
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 30),
                DropdownButton<int>(
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  value: dropdownValueDay,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (newVal) {
                    setState(() {
                      dropdownValueDay = newVal!;
                    });
                  },
                  items: List<int>.generate(31, (i) => i + 1).map((int value) {
                    return new DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
              // ),
            ),

            // TweenAnimationBuilder<Duration>(
            //     duration: Duration(minutes: 3),
            //     tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
            //     onEnd: () {
            //       print('Timer ended');
            //     },
            //     builder: (BuildContext context, Duration value, Widget? child) {
            //       final minutes = value.inMinutes;
            //       final seconds = value.inSeconds % 60;
            //       return Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 5),
            //           child: Text('$minutes:$seconds',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 30)));
            //     }),

            // MaterialApp(title: 'Stopwatch Example', home: StopwatchPage()),
          ],
        ),
      ),
    );
  }
}
