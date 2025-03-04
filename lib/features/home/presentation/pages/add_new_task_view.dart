import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/appbar/custom_appbar.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_date_textfield.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/drop_menu_text_field.dart';

class AddNewTaskView extends StatelessWidget {
  const AddNewTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add new task"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                color: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.uploadImgIc),
                    SizedBox(width: 5.w),
                    Text("Add Img", style: AppStyles.medium19Primary),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextTextField(
                text: "Task title",
                hintText: "Enter title here...",
                removeSuffix: true,
                removePrefix: true,
                controller: TextEditingController(),
              ),
              CustomTextTextField(
                text: "Task Description",
                hintText: "Enter description here...",
                maxLine: 6,
                removeSuffix: true,
                removePrefix: true,
                controller: TextEditingController(),
              ),
              CustomDropdownTextField(
                text: "Priority",
                style: AppStyles.bold16White.copyWith(color: AppColors.primary),
                removeSuffix: true,
                prefix: SvgPicture.asset(AppIcons.flagIc),
                fillColor: Color(0xffF0ECFF),
                isFilled: true,
                dropSufffix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset(AppIcons.dropMenuIc),
                ),
                items: ["Low Priority", "Medium Priority", "High Priority"],
              ),
              CustomDateTextField(
                text: "Due date",
                dateController: TextEditingController(),
                hint: "choose due date...",
              ),
              SizedBox(height: 8.h),
              CustomElevatedButton(title: "Add task", onPressed: () {}),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
