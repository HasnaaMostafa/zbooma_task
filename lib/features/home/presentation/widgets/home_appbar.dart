import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_assets.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/features/auth/presentation/pages/login_view.dart';
import 'package:zbooma_task/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:zbooma_task/features/profile/presentation/pages/profile_view.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final TaskPreferences preferences = sl<TaskPreferences>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Image.asset(AppImages.appLogo, height: 32.h),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfileView(),
              ),
            );
          },
          child: SvgPicture.asset(AppIcons.profileIc),
        ),
        SizedBox(width: 8.w),
        BlocProvider(
          create: (context) => ProfileCubit(sl()),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginView(),
                  ),
                  (route) => false,
                );
              }
              if (state is LogoutError) {
                showToast(message: state.error, state: ToastStates.error);
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<ProfileCubit>().logout();
                  preferences.deleteToken();
                  preferences.deleteRefreshToken();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 12.0.w),
                  child:
                      state is LogoutLoading
                          ? SpinKitThreeBounce(
                            key: const ValueKey('loadinglogout'),
                            color: AppColors.primary,
                            size: 20,
                          )
                          : SvgPicture.asset(AppIcons.logoutIc),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
