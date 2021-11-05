import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';

import 'main_page.dart';


/// Entrypoint example for registering via Email/Password.
class RegisterPage extends StatefulWidget {
  /// The page title.
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final UserController userController = UserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? _success;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: OutlinedButton.icon(
                    label: const Text('Register'),
                    icon: const Icon(Icons.person_add),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        userController.register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            error: (){
                              _success = false;
                            },
                            action: (User user){
                              setState(() {
                                _success = true;
                                _userEmail = user.email ?? '';
                                Get.offAll(const MainPage());
                              });
                            },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    _success == null
                        ? ''
                        : (_success!
                            ? 'Successfully registered $_userEmail'
                            : 'Registration failed'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
