import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    this.isCopy = false,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final bool? isCopy;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        decoration: ShapeDecoration(
          color: Color(0xffF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.medium12.copyWith(
                color: Color(0xff2F2F2F).withValues(alpha: 0.4),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  subtitle,
                  style: AppStyles.bold19white.copyWith(
                    fontSize: 18.h,
                    color: Color(0xff2F2F2F).withValues(alpha: 0.6),
                  ),
                ),
                Spacer(),
                if (isCopy == true)
                  GestureDetector(
                    onTap: onTap,
                    child: SvgPicture.asset(AppIcons.copyIc),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
