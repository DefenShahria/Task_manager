import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/ui/screens/auth/signinScreen.dart';
import 'package:task1/ui/screens/main_bottomnav.dart';
import 'package:task1/ui/state_holder/controller/auth_controller.dart';

class splashscrn extends StatefulWidget {
  const splashscrn({super.key});

  @override
  State<splashscrn> createState() => _splashscrnState();
}

class _splashscrnState extends State<splashscrn> {






  @override
  void initState() {
    super.initState();
    navigatetologin();
  }

  void navigatetologin() {
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedin = await AuthController.isLoggedin;
      if(mounted){
        Get.offAll(isLoggedin ? const MainBottomNavScreen() : const SignInPage());
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Task Manager Apk"),
      ),
    );
  }
}
