import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CustomDropdownTextField extends StatefulWidget {
  const CustomDropdownTextField({
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
    required this.items,
    this.selectedValue,
    this.onDropdownChanged,
    this.isFilled = false,
    this.fillColor,
    this.labelText,
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
  final List<String> items;
  final String? selectedValue;
  final void Function(String?)? onDropdownChanged;
  final bool? isFilled;
  final Color? fillColor;
  final String? labelText;

  @override
  State<CustomDropdownTextField> createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  String? _selectedValue;

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
              style: widget.labelStyle ?? AppStyles.regular14Grey7F,
            ),
          if (widget.text != null) const SizedBox(height: 15),
          SizedBox(
            child: DropdownButtonFormField<String>(
              style: widget.style ?? AppStyles.regular14Grey7F,
              icon: widget.dropSufffix,
              value: _selectedValue,

              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                if (widget.onDropdownChanged != null) {
                  widget.onDropdownChanged!(newValue);
                }
              },
              items:
                  widget.items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: widget.style ?? AppStyles.regular14Grey7F,
                      ),
                    );
                  }).toList(),
              decoration: InputDecoration(
                labelStyle: widget.labelStyle,
                labelText: widget.labelText,
                fillColor: widget.fillColor,
                filled: widget.isFilled,
                contentPadding: EdgeInsets.symmetric(vertical: 18.h),
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
