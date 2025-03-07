import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_cubit.dart';
import 'package:zbooma_task/features/home/presentation/pages/home_view.dart';
import 'package:zbooma_task/features/intro/presentation/pages/intro_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TaskPreferences preferences = sl<TaskPreferences>();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (preferences.getToken() != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder:
                  (BuildContext context) => BlocProvider(
                    create: (context) => TaskCubit(sl()),
                    child: HomeView(),
                  ),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => IntroView()),
            (route) => false,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            Container(color: AppColors.primary),
            Center(
              child: Hero(
                tag: "App Name",
                child: SizedBox(
                  height: 45,
                  child: SvgPicture.asset(AppIcons.logo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
