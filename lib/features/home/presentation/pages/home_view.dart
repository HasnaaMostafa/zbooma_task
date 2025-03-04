import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/features/home/presentation/widgets/animated_fab.dart';
import 'package:zbooma_task/features/home/presentation/widgets/category_listview.dart';
import 'package:zbooma_task/features/home/presentation/widgets/task_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFAB(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Image.asset(AppImages.appLogo, height: 32.h),
        ),
        actions: [
          SvgPicture.asset(AppIcons.profileIc),
          SizedBox(width: 8.w),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SvgPicture.asset(AppIcons.logoutIc),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Tasks",
              style: AppStyles.bold16White.copyWith(
                color: Color(0xff24252C).withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 16.h),
            CategoryListView(),
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TaskItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}
