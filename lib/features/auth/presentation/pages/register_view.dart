import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/drop_menu_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/phone_number_text_field.dart';
import 'package:zbooma_task/features/auth/presentation/cubit/cubit/auth_cubit_cubit.dart';
import 'package:zbooma_task/features/auth/presentation/pages/login_view.dart';
import 'package:zbooma_task/features/home/presentation/pages/home_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  TextEditingController yearsOfExperiencesController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String? levelOfExperencies;

  GlobalKey<FormState> formKey = GlobalKey();
  String? code;

  @override
  void dispose() {
    phoneController.dispose();
    passwordContoller.dispose();
    yearsOfExperiencesController.dispose();
    addressController.dispose();
    nameController.dispose();
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
                        controller: nameController,
                      ),
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
                        keyboardType: TextInputType.number,
                        hintText: "Years of experience...",
                        removePrefix: true,
                        controller: yearsOfExperiencesController,
                      ),
                      CustomTextTextField(
                        hintText: "Address...",
                        removePrefix: true,
                        controller: addressController,
                      ),
                      CustomDropdownTextField(
                        removeSuffix: true,
                        dropSufffix: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: SvgPicture.asset(AppIcons.arrowMenuIc),
                          ),
                        ),
                        removePrefix: true,
                        hintText: "Choose experience Level",
                        items: ["fresh", "junior", "midLevel", "senior"],
                        selectedValue: levelOfExperencies,
                        onDropdownChanged: (String? newValue) {
                          setState(() {
                            levelOfExperencies = newValue;
                          });
                          print(levelOfExperencies);
                        },
                      ),
                      CustomTextTextField(
                        isLast: true,
                        isPassword: true,
                        hintText: "Password...",
                        removePrefix: true,
                        controller: passwordContoller,
                      ),
                      SizedBox(height: 24.h),
                      BlocProvider(
                        create: (context) => AuthCubit(sl()),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is RegisterSuccess) {
                              showToast(
                                message: "Register Successfully",
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
                              title: "Sign up",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().register(
                                    phone:
                                        code == null
                                            ? "20${phoneController.text}"
                                            : phoneController.text,
                                    password: passwordContoller.text,
                                    name: nameController.text,
                                    experiences: int.parse(
                                      yearsOfExperiencesController.text,
                                    ),
                                    level: levelOfExperencies ?? "",
                                    address: addressController.text,
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
                            "Already have any account? ",
                            style: AppStyles.regular14Grey7F,
                          ),
                          CustomTextButton(
                            text: "Sign In",
                            decoration: TextDecoration.underline,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (BuildContext context) => LoginView(),
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
