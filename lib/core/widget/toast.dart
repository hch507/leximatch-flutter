import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,

    backgroundColor: const Color(0xCC2F2F2F),
    textColor: Colors.white,

    fontSize: 14,

    webBgColor:
    "linear-gradient(to right, #2F2F2F, #2F2F2F)",
  );
}
