// Remove an item from shared preferences

import 'package:shared_preferences/shared_preferences.dart';

Future<void> removeItemFromSharedPreferences(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
