import 'package:get/get.dart';
import 'package:task1/ui/state_holder/controller/addTask_controller.dart';
import 'package:task1/ui/state_holder/controller/completedTask_Controller.dart';
import 'package:task1/ui/state_holder/controller/main_bottomnav_Controller.dart';
import 'package:task1/ui/state_holder/controller/new_taskcontroller.dart';
import 'package:task1/ui/state_holder/controller/signUpController.dart';
import 'package:task1/ui/state_holder/controller/signinController.dart';
import 'package:task1/ui/state_holder/controller/taskDelet_controller.dart';

import '../ui/state_holder/controller/statusChangeController.dart';


class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(SigninController());
    Get.put(SignUpController());
    Get.put(CompleteTaskController());
    Get.put(NewTaskController());
    Get.put(DeletPostController());
    Get.put(AddNewTaskController());
    Get.put(UpdatePostController());

  }
}