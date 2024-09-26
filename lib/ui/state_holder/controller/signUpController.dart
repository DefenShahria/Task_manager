import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/ui/state_holder/controller/auth_controller.dart';
import '../../../network/networkcaller.dart';
import '../../../network/networkresponse.dart';

class SignUpController extends GetxController {
  bool _signUpVerificationInprogress = false;
  String _message = '';
  int _userid = 0;

  bool get signupverificationInprogress => _signUpVerificationInprogress;

  String get message => _message;
  int get userid => _userid;

  Future<bool> verifySignup( String email, String f_name,String l_name, String phone, String password) async {
    _signUpVerificationInprogress = true;
    update();
    final Networkresponse response = await Networkcall().postRequest(
        Urls.SignUp,
        {
          "email": email,
          "firstName":f_name,
          "lastName":l_name,
          "mobile":phone,
          "password":password
        });
    _signUpVerificationInprogress = false;
    update();
    log('Signup Response: ${response.responseJson}');
    if (response.issuccess) {
      await AuthController.setAccessToken(response.responseJson?['token']);
      _message = response.responseJson?['status'] ?? '';
      return true;
    } else {
      _message = response.responseJson?['message'] ?? 'Signup failed';
      return false;
    }
  }
}
