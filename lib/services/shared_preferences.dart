import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  Future<bool> readSharedPreferences(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userPrefs = prefs.getString(id) != null ? true : false;
    return userPrefs;
  }

  Future<void> setSharedPreferences(String id, String name, String email,
      String phoneNo, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'password': password,
    };
    bool result = await prefs.setString(id, jsonEncode(user));
    print(result);
  }

  Future<bool> getSharedPreferences(
      String id, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userPrefs = prefs.getString(id);
    Map<String, dynamic> user = jsonDecode(userPrefs!) as Map<String, dynamic>;
    print(user);

    String storedemail = user['email'];
    String storedpassword = user['password'];
    if (email == storedemail && password == storedpassword) {
      return true;
    } else {
      return false;
    }
  }
}
