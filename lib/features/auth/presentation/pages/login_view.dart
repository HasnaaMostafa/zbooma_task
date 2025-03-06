import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/phone_number_text_field.dart';
import 'package:zbooma_task/features/auth/presentation/pages/register_view.dart';
import 'package:zbooma_task/features/home/presentation/pages/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.bannerImg),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login", style: AppStyles.bold24black),
                    SizedBox(height: 24.h),
                    PhoneNumberTextField(
                      phoneController: TextEditingController(),
                    ),
                    CustomTextTextField(
                      isPassword: true,
                      hintText: "Password...",
                      removePrefix: true,
                      controller: TextEditingController(),
                      isLast: true,
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                      title: "Sign In",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomeView(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn’t have any account? ",
                          style: AppStyles.regular14Grey7F,
                        ),
                        CustomTextButton(
                          text: "Sign Up here",
                          decoration: TextDecoration.underline,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (BuildContext context) => RegisterView(),
                              ),
                            );
                          },
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
