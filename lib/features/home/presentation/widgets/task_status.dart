import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class TaskStatus extends StatelessWidget {
  const TaskStatus({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.h,

      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
      decoration: ShapeDecoration(
        color: getStatusColor(status).withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: Center(
        child: Text(
          status,
          style: AppStyles.medium12.copyWith(color: getStatusColor(status)),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'finished':
        return Color(0xff0087FF);
      case 'inpogress':
        return AppColors.primary;
      case 'waiting':
        return Color(0xffFF7D53);
      default:
        return Colors.grey;
    }
  }
}
