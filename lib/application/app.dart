import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/application/controllerBinding.dart';
import 'package:task1/application/splashScreen.dart';
import 'package:task1/ui/screens/auth/signinScreen.dart';
import 'package:task1/data/colorPlate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Appcolor.more),
        useMaterial3: true,
      ),
      initialBinding: ControllerBinder(),
      home: FutureBuilder<bool>(
        future: _checkFirstLaunch(), // Call the method to check first launch
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator while checking
          }
          if (snapshot.hasData) {
            bool isFirstLaunch = snapshot.data!;
            if (isFirstLaunch) {
              return const splashscrn(); // Show splash screen if first launch
            } else {
              return const SignInPage(); // Navigate to sign-in page if not first launch
            }
          }
          return const SignInPage(); // Fallback to sign-in page
        },
      ),
    );
  }

  Future<bool> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // If it's the first launch, set it to false for future launches
      await prefs.setBool('isFirstLaunch', false);
    }

    return isFirstLaunch;
  }
}
