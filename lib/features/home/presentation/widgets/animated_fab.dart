import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class AnimatedFAB extends StatefulWidget {
  const AnimatedFAB({super.key});

  @override
  State<AnimatedFAB> createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedFAB>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeIn;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
      setState(() {});
    });

    _rotateAnimation = Tween<double>(begin: 0.0, end: 45.0 / 360.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    _translateButton = Tween<double>(begin: 0.0, end: -80.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.75, curve: _curve),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BuildAditionalFABIcon(
          title: " ",
          heroTagSuffix: "1",
          icon: AppIcons.qrIc,
          onPressed: () {},
          isOpened: isOpened,
          y: _translateButton.value,
          offset: 0.h,
        ),
        BuildMainIcon(
          rotate: _rotateAnimation,
          rotateAnimation: _rotateAnimation,
          onPressedAnimate: animate,
        ),
      ],
    );
  }
}

class BuildMainIcon extends StatelessWidget {
  const BuildMainIcon({
    super.key,
    required this.onPressedAnimate,
    required this.rotateAnimation,
    required this.rotate,
  });

  final void Function() onPressedAnimate;
  final Listenable rotateAnimation;
  final Animation<double> rotate;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40.h,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 64.h,
        width: 64.w,
        child: FloatingActionButton(
          elevation: 0,
          heroTag: 'mainFAB',
          onPressed: onPressedAnimate,
          backgroundColor: AppColors.primary,
          shape: CircleBorder(),
          child: AnimatedBuilder(
            animation: rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotate.value * 2 * 3.14159,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 3.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    Container(
                      width: 24.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildAditionalFABIcon extends StatelessWidget {
  const BuildAditionalFABIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.offset,
    required this.isOpened,
    required this.y,
    required this.heroTagSuffix,
    required this.title,
  });

  final String icon;
  final VoidCallback onPressed;
  final double offset;
  final bool isOpened;
  final double y;
  final String heroTagSuffix;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40.h + offset,
      right: 5.w,
      child: Transform(
        transform: Matrix4.translationValues(0.0, y, 0.0),
        child: Row(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: isOpened ? 1.0 : 0.0,
              child: SizedBox(
                height: 50.h,
                width: 50.w,
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: 'additionalFAB_$heroTagSuffix',
                  onPressed: onPressed,
                  mini: true,
                  backgroundColor: Color(0xffEBE5FF),
                  shape: CircleBorder(),
                  child: SvgPicture.asset(icon),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
