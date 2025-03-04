import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/icons.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key, this.padding});

  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(AppIcons.arrowIc),
      ),
    );
  }
}
