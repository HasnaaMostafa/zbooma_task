import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/icons.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.title, this.mainAxisAlignment});

  final String? title;
  final MainAxisAlignment? mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.emptyIc,
          height: 300.h,
          width: 300,
          fit: BoxFit.cover,
        ),
        Text(title ?? ""),
      ],
    );
  }
}
