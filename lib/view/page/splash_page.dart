import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';
import 'package:timesheet_flutter_app/view/page/login_page.dart';
import 'package:timesheet_flutter_app/view/page/main_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final UserController _userController = UserController();

  void _checkUser() async {
    await Future.delayed(const Duration(seconds: 10));
    bool status = _userController.checkUserStatus();
    if (status) {
      Get.offAll(const MainPage());
    } else {
      Get.offAll(LoginPage());
    }
  }

  @override
  void initState() {
    _checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/logo.svg',
            height: 300,
            width: 300,
          ),
          const SizedBox(
            height: 100,
          ),
          const SpinKitSpinningLines(
            color: Colors.blueAccent,
            size: 60.0,
          ),
        ],
      ),
    );
  }
}
