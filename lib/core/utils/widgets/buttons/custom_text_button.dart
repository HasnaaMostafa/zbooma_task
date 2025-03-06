import 'package:flutter/material.dart';
import 'package:zbooma_task/core/static/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    this.style,
    this.isDisibled,
    this.widget,
    this.decoration,
  });

  final void Function()? onPressed;
  final String text;
  final TextStyle? style;
  final bool? isDisibled;
  final Widget? widget;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child:
              isDisibled == true
                  ? widget!
                  : Text(
                    text,
                    style:
                        style ??
                        AppStyles.bold14Primary.copyWith(
                          decoration: decoration,
                        ),
                  ),
        ),
      ],
    );
  }
}
