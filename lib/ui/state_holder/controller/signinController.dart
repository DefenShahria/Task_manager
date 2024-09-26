import 'dart:developer';

import 'package:get/get.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/network/networkcaller.dart';
import 'package:task1/network/networkresponse.dart';
import 'package:task1/ui/state_holder/controller/auth_controller.dart';




class SigninController extends GetxController {
  bool _signinVerificationInprogress = false;
  String _message = '';
  int _userid = 0;

  bool get signinverificationInprogress => _signinVerificationInprogress;

  String get message => _message;
  int get userid => _userid;

  Future<bool> verifySignin(String email, String password) async {
    _signinVerificationInprogress = true;
    update();
    final Networkresponse response = await Networkcall().postRequest(
        Urls.SignIn,
        {
          "email":email,
          "password":password
        });
    _signinVerificationInprogress = false;
    update();
    log('Signin Response: ${response.responseJson}');
    if (response.issuccess) {
      await AuthController.setAccessToken(response.responseJson?['token']);
      print("AccessToken : ${response.responseJson?['token']}");
      _message = response.responseJson?['status'] ?? '';

      return true;
    } else {
      _message = response.responseJson?['message'] ?? 'Signin failed';
      return false;
    }
  }
}
