import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/application/controllerBinding.dart';
import 'package:task1/application/splashScreen.dart';
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
      home: const SplashScreen(),
    );
  }
}