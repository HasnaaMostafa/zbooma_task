import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/appbar/custom_appbar.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/features/profile/data/models/profile_model.dart';
import 'package:zbooma_task/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:zbooma_task/features/profile/presentation/widgets/profile_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(sl())..getUserData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: "Profile"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 24.h),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileGetUserDataSuccess) {
                ProfileModel user = state.profileModel;
                return Column(
                  children: [
                    ProfileItem(
                      title: "Name",
                      subtitle: user.displayName ?? "",
                    ),
                    ProfileItem(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: user.username ?? ""),
                        ).then((_) {
                          showToast(
                            message: "Number Copied to Clipboard",
                            state: ToastStates.message,
                          );
                        });
                      },
                      title: "Phone",
                      subtitle: user.username ?? "",
                      isCopy: true,
                    ),
                    ProfileItem(title: "Level", subtitle: user.level ?? ""),
                    ProfileItem(
                      title: "Years of experience",
                      subtitle: "${user.experienceYears} Years",
                    ),
                    ProfileItem(
                      title: "Location",
                      subtitle: user.address ?? "",
                    ),
                  ],
                );
              } else if (state is ProfileGetUserDataLoading) {
                return Center(
                  child: SpinKitWave(
                    key: const ValueKey('loadingProfile'),
                    color: AppColors.primary,
                    size: 20,
                    type: SpinKitWaveType.start,
                  ),
                );
              } else if (state is ProfileGetUserDataError) {
                return Center(child: Text(state.error.toString()));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
