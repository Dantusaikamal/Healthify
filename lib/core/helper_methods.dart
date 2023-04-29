// Remove an item from shared preferences
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> removeItemFromSharedPreferences(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

// Helper function to parse cookies from headers
List<Cookie> parseCookies(String header) {
  List<Cookie> cookies = [];

  if (header != null) {
    List<String> cookieHeaders = header.split(';');
    for (String cookieHeader in cookieHeaders) {
      String name = cookieHeader.split('=')[0].trim();
      String value = cookieHeader.split('=')[1].trim();
      cookies.add(Cookie(name, value));
    }
  }

  return cookies;
}
