import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/features/home/presentation/pages/add_new_task_view.dart';

class FabIcon extends StatelessWidget {
  const FabIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 64.h,
      width: 64.w,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddNewTaskView(),
            ),
          );
        },
        elevation: 0,
        heroTag: 'mainFAB',
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}
