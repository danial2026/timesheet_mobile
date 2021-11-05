import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget {
  final UserController userController = UserController();

  HomePage({Key? key}) : super(key: key);

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
                userController.signOutFromGoogle(
                    error: () {},
                    action: () {
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
            user.photoURL != null ? CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              radius: 20,
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
