import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/static/app_styles.dart';

void showMenuDialog<T>(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.only(left: 240.w, right: 10, bottom: 550),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Edit',
                  style: AppStyles.medium14Black.copyWith(fontSize: 15),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFEEEEEE),
                ),
              ),
              ListTile(
                title: Text(
                  'Delete',
                  style: AppStyles.medium14Black.copyWith(
                    fontSize: 15,
                    color: Color(0xffFF7D53),
                  ),
                ),

                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
