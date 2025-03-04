import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/appbar/custom_appbar.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_date_textfield.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/drop_menu_text_field.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Task Details", isMenu: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(AppImages.task, height: 255.h),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Grocery Shopping App", style: AppStyles.bold24black),
                  SizedBox(height: 8.h),
                  Text(
                    "This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.",
                    style: AppStyles.regular14Grey6E.copyWith(
                      color: Color(0xff24252C).withValues(alpha: 0.6),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomDateTextField(
                    isFilled: true,
                    dateController: TextEditingController(),
                    title: "End Date",
                  ),
                  CustomDropdownTextField(
                    style: AppStyles.bold16White.copyWith(
                      color: AppColors.primary,
                    ),
                    labelText: "Status",
                    labelStyle: AppStyles.regular14Grey6E,
                    removePrefix: true,
                    fillColor: Color(0xffF0ECFF),
                    isFilled: true,
                    dropSufffix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(AppIcons.dropMenuIc),
                    ),
                    selectedValue: "",
                    onDropdownChanged: (String? newValue) {
                      print("Selected: $newValue");
                    },
                    items: ["InProgress", "Waiting", "Finished"],
                  ),
                  CustomDropdownTextField(
                    style: AppStyles.bold16White.copyWith(
                      color: AppColors.primary,
                    ),
                    labelText: "Priority",
                    labelStyle: AppStyles.regular14Grey6E,
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
                  Image.asset(AppImages.qr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
