import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/features/auth/presentation/pages/login_view.dart';
import 'package:zbooma_task/features/profile/presentation/pages/profile_view.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final TaskPreferences preferences = sl<TaskPreferences>();

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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfileView(),
              ),
            );
          },
          child: SvgPicture.asset(AppIcons.profileIc),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginView()),
              (route) => false,
            );
            preferences.deleteToken();
            preferences.deleteRefreshToken();
          },
          child: Padding(
            padding: EdgeInsets.only(right: 12.0.w),
            child: SvgPicture.asset(AppIcons.logoutIc),
          ),
        ),
      ],
    );
  }
}
