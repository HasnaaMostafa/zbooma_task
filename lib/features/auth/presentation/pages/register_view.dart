import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/drop_menu_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/phone_number_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.bannerImg,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register", style: AppStyles.bold24black),
                    SizedBox(height: 24.h),
                    CustomTextTextField(
                      hintText: "Name",
                      removePrefix: true,
                      controller: TextEditingController(),
                    ),
                    PhoneNumberTextField(
                      phoneController: TextEditingController(),
                    ),
                    CustomTextTextField(
                      hintText: "Years of experience...",
                      removePrefix: true,
                      controller: TextEditingController(),
                    ),
                    CustomTextTextField(
                      hintText: "Address...",
                      removePrefix: true,
                      controller: TextEditingController(),
                    ),
                    CustomDropdownTextField(
                      removeSuffix: true,
                      dropSufffix: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SvgPicture.asset(AppIcons.arrowMenuIc),
                        ),
                      ),
                      removePrefix: true,
                      hintText: "Choose experience Level",
                      items: ["Option 1", "Option 2", "Option 3"],
                      selectedValue: "Option 1",
                      onDropdownChanged: (String? newValue) {
                        print("Selected: $newValue");
                      },
                    ),
                    CustomTextTextField(
                      isLast: true,
                      isPassword: true,
                      hintText: "Password...",
                      removePrefix: true,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(title: "Sign up", onPressed: () {}),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have any account? ",
                          style: AppStyles.regular14Grey7F,
                        ),
                        CustomTextButton(
                          text: "Sign In",
                          decoration: TextDecoration.underline,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
