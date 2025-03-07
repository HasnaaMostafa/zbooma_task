import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/phone_number_text_field.dart';
import 'package:zbooma_task/features/auth/presentation/cubit/cubit/auth_cubit_cubit.dart';
import 'package:zbooma_task/features/auth/presentation/pages/register_view.dart';
import 'package:zbooma_task/features/home/presentation/pages/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  String? code;

  @override
  void dispose() {
    phoneController.dispose();
    passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Form(
            key: formKey,
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
                        phoneController: phoneController,
                        onCountryChanged: (value) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              code = value;
                            });
                          });
                        },
                      ),
                      CustomTextTextField(
                        isPassword: true,
                        hintText: "Password...",
                        removePrefix: true,
                        controller: passwordContoller,
                        isLast: true,
                      ),
                      SizedBox(height: 24.h),
                      BlocProvider(
                        create: (context) => AuthCubit(sl()),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              showToast(
                                message: "Login Successfully",
                                state: ToastStates.success,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomeView(),
                                ),
                              );
                            }
                            if (state is AuthError) {
                              return showToast(
                                message: state.error,
                                state: ToastStates.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomElevatedButton(
                              isLoading: state is AuthLoading,
                              title: "Sign In",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                    phone:
                                        code == null
                                            ? "20${phoneController.text}"
                                            : phoneController.text,
                                    password: passwordContoller.text,
                                  );
                                }
                              },
                            );
                          },
                        ),
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
      ),
    );
  }
}
