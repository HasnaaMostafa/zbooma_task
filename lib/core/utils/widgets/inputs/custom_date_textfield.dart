import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zbooma_task/core/function/format_date.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';

class CustomDateTextField extends StatelessWidget {
  const CustomDateTextField({
    super.key,
    required this.dateController,
    this.title,
    this.hint,
    this.text,
    this.isFilled = false,
  });

  final TextEditingController dateController;
  final String? title;
  final String? hint;
  final String? text;
  final bool? isFilled;

 

  @override
  Widget build(BuildContext context) {
    return CustomTextTextField(
      text: text,
      hintText: hint,
      style: AppStyles.regular14Grey6E,
      labelStyle: AppStyles.regular14Grey6E,
      removePrefix: true,
      label: title,
      isFilled: isFilled,
      fillColor: isFilled == true ? Color(0xffF0ECFF) : Colors.transparent,
      suffix: GestureDetector(
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2030),
          );
          if (selectedDate != null) {
            final formattedDate = formatDate(selectedDate.toIso8601String());
            dateController.text = formattedDate;
          }
        },
        child: SvgPicture.asset(AppIcons.calenderIc),
      ),

      controller: dateController,
    );
  }
}
