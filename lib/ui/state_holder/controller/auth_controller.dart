



import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  static String ? _accessToken;
  static int ? _userid;

  String? get accessToken => _accessToken;
  int? get userid => _userid;

  static Future<void> setAccessToken (String token) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('accesstoken', token);
    _accessToken = token;
  }

  static Future<void> setuserid (int id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('Userid', id);
    _userid = id;
  }


  static Future<void> getAccessToken () async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('access_token');

  }

  static Future<void> getuserid() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _userid = sharedPreferences.getInt('userid');

  }

  static bool get isLoggedin{
    return _accessToken != null;
  }

  static Future<void> clearAccessToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('accesstoken');
    _accessToken = null;
  }



}