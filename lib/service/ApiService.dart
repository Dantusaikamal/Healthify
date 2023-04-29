import 'dart:convert';

import 'package:get/get.dart';
import 'package:healthify/bloc/auth_bloc/signup_bloc/signup_bloc_state.dart';
import 'package:healthify/core/constants/api_constants.dart';
import 'package:healthify/core/constants/enums.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('${APIConstant.baseUrl}/user-login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode.toInt() == 200) {
      Map<String, dynamic> userData = json.decode(response.body);

      final pref = await SharedPreferences.getInstance();
      await pref.setBool(AuthState.unknown.toString(), false);
      await pref.setString(
          AuthState.authToken.toString(), "${userData['token']}");
      await pref.setBool(AuthState.authenticated.toString(), true);

      return userData;
    } else {
      final error = json.decode(response.body);

      if (error['message'] == "Invalid Email or Password" ||
          error['message'] == "Please enter email and password") {
        SignUpFailure(errorMessage: error['message']);
        throw Exception(error['message']);
      } else {
        const SignUpFailure(errorMessage: "Failed to register");
        throw Exception("Failed to register");
      }
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('${APIConstant.baseUrl}/user-register'),
      body: {
        'fullName': fullName,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode.toInt() == 201) {
      Map<String, dynamic> userData = json.decode(response.body);

      final pref = await SharedPreferences.getInstance();
      await pref.setBool(AuthState.unknown.toString(), false);
      await pref.setString(
          AuthState.authToken.toString(), "${userData['token']}");
      await pref.setBool(AuthState.authenticated.toString(), true);

      return userData;
    } else {
      final error = json.decode(response.body);

      if (error['message'] == "Duplicate email Entered") {
        SignUpFailure(errorMessage: error['message']);
        throw Exception(error['message']);
      } else {
        const SignUpFailure(errorMessage: "Failed to register");
        throw Exception("Failed to register");
      }
    }
  }
}
