import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final bool isFilled;
  final bool loading;
  final String? icon;
  final bool isAssetIcon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onPressed;
  final double? height;
  final bool reverse;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? style;
  final bool? isSpace;
  final double? padding;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final double? width;

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.isFilled = true,
    required this.onPressed,
    this.height = 50,
    this.icon,
    this.isAssetIcon = false,
    this.iconColor = Colors.white,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.primary,
    this.loading = false,
    this.reverse = false,
    this.borderRadius,
    this.style,
    this.isSpace = false,
    this.padding,
    this.borderColor,
    this.boxShadow,
    this.width,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!_isPressed) {
          _controller.forward();
          setState(() => _isPressed = true);
        }
      },
      onTapUp: (_) {
        _controller.reverse();
        setState(() => _isPressed = false);
        _handlePress();
      },
      onTapCancel: () {
        _controller.reverse();
        setState(() => _isPressed = false);
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _isPressed ? 0.7 : (widget.loading ? 0.5 : 1.0),
              child: Container(
                width: widget.width ?? double.infinity,
                height: widget.height?.h ?? 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(10),
                  border:
                      !widget.isFilled
                          ? Border.all(
                            color: widget.borderColor ?? AppColors.grey78,
                            width: 1,
                          )
                          : null,
                  color:
                      widget.isFilled
                          ? widget.backgroundColor
                          : AppColors.white,
                  boxShadow:
                      widget.boxShadow ??
                      (widget.isFilled
                          ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ]
                          : null),
                ),
                padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child:
                      widget.loading
                          ? SpinKitWave(
                            key: const ValueKey('loading'),
                            color: widget.iconColor,
                            size: 20,
                            type: SpinKitWaveType.start,
                          )
                          : Row(
                            key: const ValueKey('content'),
                            mainAxisAlignment:
                                widget.isSpace == true
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                            children:
                                widget.reverse
                                    ? [
                                      if (widget.icon != null) ...[
                                        widget.isAssetIcon
                                            ? Image.asset(widget.icon!)
                                            : SvgPicture.asset(
                                              widget.icon!,
                                              colorFilter:
                                                  widget.iconColor != null
                                                      ? ColorFilter.mode(
                                                        widget.iconColor!,
                                                        BlendMode.srcIn,
                                                      )
                                                      : null,
                                            ),
                                      ],
                                      if (widget.isSpace == false)
                                        SizedBox(width: 8.w),
                                      Text(
                                        widget.title,
                                        style:
                                            widget.style ??
                                            AppStyles.bold19white,
                                      ),
                                      if (widget.icon != null)
                                        SizedBox(width: 8.w),
                                    ]
                                    : [
                                      if (widget.icon != null)
                                        SizedBox(width: 20.w),
                                      Text(
                                        widget.title,
                                        style:
                                            widget.style ??
                                            AppStyles.bold19white,
                                      ),
                                      if (widget.isSpace == false)
                                        SizedBox(width: 8.w),
                                      if (widget.icon != null) ...[
                                        widget.isAssetIcon
                                            ? Image.asset(widget.icon!)
                                            : SvgPicture.asset(
                                              widget.icon!,
                                              colorFilter:
                                                  widget.iconColor != null
                                                      ? ColorFilter.mode(
                                                        widget.iconColor!,
                                                        BlendMode.srcIn,
                                                      )
                                                      : null,
                                            ),
                                      ],
                                    ],
                          ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
