import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/features/home/presentation/pages/add_new_task_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.isMenu = false});

  final String title;
  final bool? isMenu;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Transform.rotate(
          angle: 135,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SvgPicture.asset(
              AppIcons.arrowIc,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: AppStyles.bold16White.copyWith(color: Colors.black),
      ),
      centerTitle: false,
      actions: [
        if (isMenu == true)
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AddNewTaskView(),
                ),
              );
            },
            icon: Icon(Icons.more_vert_sharp),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
