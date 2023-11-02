import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BaseTheme {
  static double fontSizeNormal = 14;
  static double fontSizeSmall = 12;
  static double fontSizeVerySmall = 10;
  static double fontSizeLarge = 16;
  static double fontSizeVeryLarge = 18;
  static double fontSizeHuge = 40;
  static EdgeInsets marginAll = const EdgeInsets.all(8);
  static EdgeInsets marginAllSmall = const EdgeInsets.all(4);
  static EdgeInsets marginAllLarge = const EdgeInsets.all(16);

  static EdgeInsets marginVertical = const EdgeInsets.symmetric(vertical: 8);

  static EdgeInsets marginHorizontal = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static EdgeInsets marginHorizontalSmall = const EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 4,
  );
  static EdgeInsets marginHorizontalLarge = const EdgeInsets.symmetric(
    horizontal: 32,
    vertical: 16,
  );

  static String dateFormat(DateTime? value) {
    DateFormat dateFormat = DateFormat.yMd();
    if (value == null) {
      return '';
    } else {
      return dateFormat.format(value);
    }
  }

  static PreferredSizeWidget appBar(String title, {Color? textColor}) {
    PreferredSizeWidget appBar = AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
    return appBar;
  }

  static Widget loading() {
    return const CircularProgressIndicator(
      color: Colors.grey,
    );
  }
}
