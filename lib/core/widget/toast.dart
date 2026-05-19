import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: const Color(0xFFFFF8E8),
    textColor: const Color(0xFF4A3A2A),
    fontSize: 14,
    webBgColor: "linear-gradient(to right, #FFF8E8, #FFF8E8)",
  );
}
