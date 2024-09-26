import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/ui/screens/auth/signinScreen.dart';
import 'package:task1/ui/screens/main_bottomnav.dart';
import 'package:task1/ui/state_holder/controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstTimeAndNavigate();
  }

  Future<void> checkFirstTimeAndNavigate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      navigateToLogin();
    } else {
      Get.to(const SignInPage());
    }
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () async {
      final bool isLoggedIn = await AuthController.isLoggedin; // Ensure this returns a Future<bool>
      if (isLoggedIn) {
        Get.to(const MainBottomNavScreen());
      } else {
        Get.to(const SignInPage());
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
