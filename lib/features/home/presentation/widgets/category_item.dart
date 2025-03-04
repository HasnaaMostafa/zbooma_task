import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.primary : Color(0xffF0ECFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style:
                isSelected ? AppStyles.bold16White : AppStyles.regular16Grey7C,
          ),
        ),
      ),
    );
  }
}
