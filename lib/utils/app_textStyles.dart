import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {
  static TextStyle extraSmallTextStyle() =>
      TextStyle(fontSize: 10.sp, color: Colors.white);

  static TextStyle smallTextStyle() =>
      TextStyle(fontSize: 12.sp, color: Colors.white);

  static TextStyle mediumTextStyle() =>
      TextStyle(fontSize: 14.sp, color: Colors.white);

  static TextStyle largeTextStyle() =>
      TextStyle(fontSize: 16.sp, color: Colors.white);

  static TextStyle extraLargeTextStyle() =>
      TextStyle(fontSize: 18.sp, color: Colors.white);

  static TextStyle boldStyle() => TextStyle(
      fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold);
}
