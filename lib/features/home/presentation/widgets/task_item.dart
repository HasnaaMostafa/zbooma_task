import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/features/home/data/models/task_model.dart';
import 'package:zbooma_task/features/home/presentation/pages/task_details_view.dart';
import 'package:zbooma_task/features/home/presentation/widgets/task_status.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskModel});

  final TaskModel taskModel;

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
                        taskModel.title ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.bold16White.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TaskStatus(status: taskModel.status ?? ""),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  taskModel.desc ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.regular14Grey6E.copyWith(
                    color: Color(0xff24252C).withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.flagIc,
                      colorFilter: ColorFilter.mode(
                        getPriorityColor(taskModel.priority ?? ""),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      taskModel.priority ?? "",
                      style: AppStyles.medium12.copyWith(
                        color: getPriorityColor(taskModel.priority ?? ""),
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

Color getPriorityColor(String status) {
  switch (status.toLowerCase()) {
    case 'low':
      return Color(0xff0087FF);
    case 'medium':
      return AppColors.primary;
    case 'high':
      return Color(0xffFF7D53);
    default:
      return Colors.grey;
  }
}
