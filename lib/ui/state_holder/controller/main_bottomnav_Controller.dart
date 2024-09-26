import 'package:get/get.dart';

class MainBottomNavController extends GetxController{
  int currentSelectedIndex = 0;

  void changeScreen(int index){
    currentSelectedIndex = index;
    update();
  }

  void backtoHome(){
    changeScreen(0);
  }

  // void backtoService(){
  //   changeScreen(2);
  // }
}