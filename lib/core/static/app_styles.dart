import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class AppStyles {
  static TextStyle bold24black = TextStyle(
    color: AppColors.black,
    fontSize: 24.r,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bold19white = TextStyle(
    color: AppColors.white,
    fontSize: 19.r,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bold16White = TextStyle(
    color: AppColors.white,
    fontSize: 16.r,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bold14Grey = TextStyle(
    color: AppColors.grey7F,
    fontSize: 14.r,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bold14Primary = TextStyle(
    color: AppColors.primary,
    fontSize: 14.r,
    fontWeight: FontWeight.bold,
  );

  static TextStyle medium14Black = TextStyle(
    color: Color(0xff2F2F2F),
    fontSize: 14.r,
    fontWeight: FontWeight.w500,
  );
  static TextStyle medium12 = TextStyle(
    color: Color(0xff2F2F2F),
    fontSize: 12.r,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium19Primary = TextStyle(
    color: AppColors.primary,
    fontSize: 19.r,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regular12Grey6E = TextStyle(
    color: AppColors.grey6E,
    fontSize: 12.r,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regular14Grey6E = TextStyle(
    color: AppColors.grey6E,
    fontSize: 14.r,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular14Grey7F = TextStyle(
    color: AppColors.grey7F,
    fontSize: 14.r,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular16Grey7C = TextStyle(
    color: AppColors.grey7C,
    fontSize: 16.r,
    fontWeight: FontWeight.w400,
  );
}
