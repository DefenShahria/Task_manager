import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:task1/network/networkresponse.dart';
import 'package:task1/ui/state_holder/controller/auth_controller.dart';



class Networkcall {
  static Future<Networkresponse> getRequest(String url) async {
    try {
      Response response = await get(
          Uri.parse(url),
          headers: {
            'token': '${AuthController().accessToken}'
          }
      );
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        return Networkresponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        // Handle unauthorized response if needed
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error: $e');
    }
    return Networkresponse(false, -1, null);
  }

  Future<Networkresponse> postRequest(String url, Map<String, dynamic> body,
      {bool islogin = false}) async {
    log('Access Token: ${AuthController().accessToken}');
    try {
      log('Request Body: $body');
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': '${AuthController().accessToken}'
        },
        body: jsonEncode(body),
      );
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        try {
          return Networkresponse(
              true, response.statusCode, jsonDecode(response.body));
        } catch (e) {
          log('Error Decoding Response: $e');
        }
      } else if (response.statusCode == 401 && !islogin) {
        await gotoLogin();
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error: $e');
    }
    return Networkresponse(false, -1, null);
  }

  Future<void> gotoLogin() async {
    // Navigate to login screen
  }
}
