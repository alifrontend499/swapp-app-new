import 'package:flutter/material.dart';

// shared preferences
import 'package:shared_preferences/shared_preferences.dart';

// app consts
import 'package:app/theme/commonConst/textConsts.dart';

void appLogout() async {
  // shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.remove(SHARED_PREF_KEY_IS_USER_LOGGED_IN);
}