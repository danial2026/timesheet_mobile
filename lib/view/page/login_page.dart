import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';
import 'package:timesheet_flutter_app/view/page/register_page.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserController userController = UserController();
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: Colors.blueAccent),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text("Please select one item and completed",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Center(child: _GoogleSignIn(size)),
            const SizedBox(
              height: 10,
            ),
            buildRowDivider(size: size),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Center(
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Please Enter Email",
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Center(
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "Please Enter Password",
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Center(
                child: OutlinedButton(
                  onPressed: () {
                    userController.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        error: (){},
                        action: (User user){
                          Get.offAll(const MainPage());
                        });
                  },
                  child: const Text("Login"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade200),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: InkWell(
                    onTap: () => Get.to(RegisterPage()),
                    child: const Text("Move To register page"))),
          ],
        ),
      ),
    );
  }

  Widget buildRowDivider({required Size size}) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(children: const <Widget>[
        Expanded(
            child: Divider(
          color: Colors.black,
        )),
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Or",
            )),
        Expanded(
            child: Divider(
          color: Colors.black,
        )),
      ]),
    );
  }

  Widget _GoogleSignIn(Size size) {
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton.icon(
              // icon: FaIcon(FontAwesomeIcons.google),
              icon: const Icon(Icons.add),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  await userController.signInWithGoogle();
                  Get.offAll(const MainPage());
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    showMessage(e.message!);
                  }
                }
                setState(() {
                  isLoading = false;
                });
              },
              label: const Text(
                'Login With Google Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade200),
                side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
              ),
            ),
          )
        : CircularProgressIndicator();
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
