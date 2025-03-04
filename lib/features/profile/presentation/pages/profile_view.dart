import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/utils/widgets/appbar/custom_appbar.dart';
import 'package:zbooma_task/features/profile/presentation/widgets/profile_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 24.h),
        child: Column(
          children: [
            ProfileItem(title: "Name", subtitle: "Islam Sayed"),
            ProfileItem(
              title: "Phone",
              subtitle: "+20 123 456-7890",
              isCopy: true,
            ),
            ProfileItem(title: "Level", subtitle: "Senior"),
            ProfileItem(title: "Years of experience", subtitle: "7 Years"),
            ProfileItem(title: "Location", subtitle: "Fayyum, Egypt"),
          ],
        ),
      ),
    );
  }
}
