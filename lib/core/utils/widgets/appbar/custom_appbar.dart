import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/features/home/presentation/widgets/show_dialog.dart';

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
              showMenuDialog(context);
            },
            icon: Icon(Icons.more_vert_sharp),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

//PopupMenuButton<int>(
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(8.r),
//   ),
//   color: Colors.white,
//   offset: const Offset(0, 40),
//   itemBuilder:
//       (context) => [
//         PopupMenuItem(
//           value: 1,
//           child: Text(
//             "Edit",
//             style: AppStyles.medium14Black.copyWith(fontSize: 16),
//           ),
//         ),
//         const PopupMenuDivider(),
//         PopupMenuItem(
//           value: 2,
//           child: Text(
//             "Delete",
//             style: AppStyles.medium14Black.copyWith(
//               fontSize: 16,
//               color: Color(0xffFF7D53),
//             ),
//           ),
//         ),
//       ],
//   onSelected: (value) {
//     if (value == 1) {
//     } else if (value == 2) {
//       Navigator.pop(context);
//     }
//   },
//   icon: const Icon(Icons.more_vert_sharp),
// )
