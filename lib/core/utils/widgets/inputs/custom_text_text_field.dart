import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CustomTextTextField extends StatefulWidget {
  const CustomTextTextField({
    super.key,
    this.hintText,
    this.suffix,
    this.isPassword,
    this.suffixPressed,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.style,
    this.onChanged,
    this.onSaved,
    this.text,
    this.prefix,
    this.height,
    this.prefixPressed,
    this.maxLine,
    this.enabled,
    this.suffixText,
    this.removeSuffix,
    this.removePrefix,
    this.fontSize,
    this.labelStyle,
    this.hintStyle,
    this.isLast,
    this.isSupport,
    this.isLogin,
    this.isEnabled,
    this.dropSufffix,
    this.isFilled = false,
    this.fillColor,
    this.label,
  });

  final String? hintText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? isPassword;
  final void Function()? suffixPressed;
  final void Function()? prefixPressed;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? text;
  final double? height;
  final int? maxLine;
  final bool? enabled;
  final String? suffixText;
  final bool? removePrefix;
  final bool? removeSuffix;
  final double? fontSize;
  final bool? isSupport;
  final bool? isLast;
  final bool? isEnabled;
  final bool? isLogin;
  final Widget? dropSufffix;
  final bool? isFilled;
  final Color? fillColor;
  final String? label;

  @override
  State<CustomTextTextField> createState() => _CustomTextTextFieldState();
}

class _CustomTextTextFieldState extends State<CustomTextTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isLast == true ? 0 : 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.text != null)
            Text(
              widget.text ?? "",
              style: widget.labelStyle ?? AppStyles.regular14Grey6E,
            ),
          if (widget.text != null) const SizedBox(height: 15),
          SizedBox(
            child: TextFormField(
              enabled: widget.isEnabled ?? true,
              maxLines: widget.maxLine ?? 1,
              onSaved: widget.onSaved,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              validator:
                  widget.validator ??
                  (String? value) {
                    if (value!.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
              obscureText: _obscureText,
              style: AppStyles.regular14Grey7F,
              decoration: InputDecoration(
                labelStyle: widget.labelStyle,
                labelText: widget.label,
                filled: widget.isFilled,
                fillColor: widget.fillColor,
                contentPadding: const EdgeInsets.all(18),
                suffixIconConstraints:
                    widget.removeSuffix == true
                        ? const BoxConstraints(maxWidth: 0)
                        : null,
                prefixIconConstraints:
                    widget.removePrefix == true
                        ? const BoxConstraints(maxWidth: 7)
                        : null,
                suffixText: widget.suffixText ?? "",
                errorText: null,
                enabled: widget.enabled ?? true,
                prefixIcon: IconButton(
                  icon: widget.prefix ?? const SizedBox(),
                  onPressed: widget.prefixPressed,
                ),
                suffixIcon:
                    widget.dropSufffix ??
                    ((widget.isPassword == true)
                        ? IconButton(
                          icon:
                              _obscureText == true
                                  ? SvgPicture.asset(
                                    AppIcons.eyeSlashIc,
                                    colorFilter: ColorFilter.mode(
                                      Color(0xffBABABA),
                                      BlendMode.srcIn,
                                    ),
                                  )
                                  : SvgPicture.asset(
                                    AppIcons.eyeIc,
                                    colorFilter: ColorFilter.mode(
                                      Color(0xffBABABA),
                                      BlendMode.srcIn,
                                    ),
                                  ),

                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                        : IconButton(
                          icon: widget.suffix ?? const SizedBox(),
                          onPressed: widget.suffixPressed,
                        )),
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? AppStyles.regular14Grey7F,
                enabledBorder: outlineInputBorderTextField(),
                border: outlineInputBorderTextField(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                disabledBorder: outlineInputBorderTextField(),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder outlineInputBorderTextField() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color:
            widget.isFilled == true
                ? Colors.transparent
                : AppColors.borderColor,
      ),
    );
  }
}
