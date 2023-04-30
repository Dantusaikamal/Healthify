import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:healthify/core/constants/api_constants.dart';
import 'package:healthify/core/constants/enums.dart';
import 'package:healthify/models/response/signin_reponse.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationRepository {
  Future<SignInResponse> signInUser(String email, String password);
}

class AuthRepository extends AuthenticationRepository {
  @override
  Future<SignInResponse> signInUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(
        '${APIConstant.baseUrl}/user-login',
      ),
      body: json.encode({
        "email": email,
        "password": password,
      }),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);

      final pref = await SharedPreferences.getInstance();

      pref.setString(AuthState.authToken.toString(), userData['token']);
      pref.setBool(AuthState.unknown.toString(), false);
      pref.setBool(AuthState.authenticated.toString(), true);

      return SignInResponse.fromJson(response.body);
    } else {
      debugPrint("Error in the api call , ${response.statusCode}");
      throw Exception("Failed to login");
    }
  }
}
