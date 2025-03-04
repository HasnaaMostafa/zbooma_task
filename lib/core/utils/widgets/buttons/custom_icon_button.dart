import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CustomIconButton extends StatelessWidget {
  // final double size;
  final Color color;
  final String iconAsset;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    // required this.size,
    required this.color,
    required this.iconAsset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
