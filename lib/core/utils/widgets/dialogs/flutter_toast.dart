import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zbooma_task/core/theme/colors.dart';

void showToast({required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity:
          state == ToastStates.message
              ? ToastGravity.CENTER
              : ToastGravity.BOTTOM,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 15,
    );

enum ToastStates { success, error, warning, message, note }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;

    case ToastStates.message:
      color = AppColors.primary;
      break;

    case ToastStates.note:
      color = Colors.grey;
      break;
  }
  return color;
}
