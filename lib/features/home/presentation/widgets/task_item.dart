import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/features/home/presentation/pages/task_details_view.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TaskDetailsView(),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.task)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Grocery Shopping App",
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.bold16White.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TaskStatus(),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "This application is designed for super shops. By using ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.regular14Grey6E.copyWith(
                    color: Color(0xff24252C).withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.flagIc),
                    SizedBox(width: 2.w),
                    Text(
                      "Low",
                      style: AppStyles.medium12.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "30/12/2022",
                      style: AppStyles.regular12Grey6E.copyWith(
                        color: Color(0xff24252C).withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskStatus extends StatelessWidget {
  const TaskStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.h,

      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
      decoration: ShapeDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: Center(
        child: Text(
          "Inprogress",
          style: AppStyles.medium12.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
