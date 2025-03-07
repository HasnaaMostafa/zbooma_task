import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? loadingColor;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;
  final String? iconPath;
  final bool isAssetIcon;
  final Color? iconColor;
  final bool iconLeading;
  final double iconSpacing;

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.isLoading = false,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.loadingColor = Colors.white,
    this.width,
    this.height = 50,
    this.borderRadius,
    this.textStyle,
    this.iconPath,
    this.isAssetIcon = false,
    this.iconColor,
    this.iconLeading = true,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Opacity(
        opacity: isLoading ? 0.7 : 1.0,
        child: Container(
          width: width ?? double.infinity,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                isLoading
                    ? SpinKitWave(
                      color: loadingColor,
                      size: 20,
                      type: SpinKitWaveType.start,
                    )
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style:
                              textStyle ??
                              TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                        if (iconPath != null && iconLeading)
                          SizedBox(width: iconSpacing),
                        if (iconPath != null && iconLeading) _buildIcon(),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      iconPath!,
      colorFilter:
          iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
      width: 24,
      height: 24,
    );
  }
}
