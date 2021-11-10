import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  success,
  warning,
  error,
}

Color chooseToastColor({
  required ToastStates state,
}) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }

  return color;
}

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state: state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
