import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color lightDarkBlue = fromHex("#92A3FD");

  static Color lightSkyBlue = fromHex("#9DCEFF");

  static Color lightpink = fromHex("#EEA4CE");

  static Color lightPurple = fromHex("#C58BF2");

  static Color bluedark = fromHex('#21243D');

  static Color bluelessdark = fromHex('#2d3152');

  static Color whiteBackground = fromHex("#ffffff");

  static Color whiteText = fromHex("#ffffff");

  static Color warningColor = fromHex("#FBDC8E");

  static Color pupuleColor = fromHex("#7042C9");

  static Color greenColor = fromHex("#0DB1AD");

  static Color blueColor = fromHex("#197BD2");

  static Color lightRed = fromHex("#FC6565");

  static Color lightGray = fromHex("#C4C1C1");

  static Color gray = fromHex("#9F9F9F");

  static Color bluegray9006c = fromHex('#6c20233c');

  static Color lightBlue = fromHex('#1353CF');

  static Color shadowColorBase = fromHex('#233565');
  static Color shadowColor = shadowColorBase.withOpacity(0.08);

  static Color cardShadowColor = fromHex('#000000').withOpacity(0.02);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
