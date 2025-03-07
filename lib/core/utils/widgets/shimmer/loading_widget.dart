import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        key: const ValueKey('loadingTask'),
        color: AppColors.primary,
        size: 20,
        type: SpinKitWaveType.start,
      ),
    );
  }
}
