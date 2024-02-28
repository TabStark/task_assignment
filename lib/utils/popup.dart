import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class PopUpMenu {
  static void showFlushBarBottom(BuildContext context, String msg) {
    Flushbar(
      backgroundColor: Colors.white,
      message: msg,
      messageColor: Colors.black,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
