import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task1/ui/screens/bottomnav_bar/complete_task/complete_task.dart';
import 'package:task1/ui/screens/bottomnav_bar/my_profile/profile.dart';
import 'package:task1/ui/screens/bottomnav_bar/new_task/new_task.dart';
import 'package:task1/ui/state_holder/controller/new_taskcontroller.dart';
import '../../../data/colorPlate.dart';
import '../state_holder/controller/main_bottomnav_Controller.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {



  final List<Widget> _screen = [
     const New_task(),
     const Complete_Task(),
     const Profile(),

  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<NewTaskController>().getNewTask();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
        builder: (controller) {
          return Scaffold(
            body: _screen[controller.currentSelectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentSelectedIndex,
              onTap: controller.changeScreen,
              selectedItemColor: Appcolor.primarycolor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              elevation: 4,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.reviews_outlined),label: 'In progress'),
                BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined),label: 'Complete'),
                BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: 'Profile'),
               
              ],),
          );
        }
    );
  }
}