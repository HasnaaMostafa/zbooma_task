import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/icons.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Image.asset(AppImages.appLogo, height: 32.h),
      ),
      actions: [
        SvgPicture.asset(AppIcons.profileIc),
        SizedBox(width: 8.w),
        Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: SvgPicture.asset(AppIcons.logoutIc),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
