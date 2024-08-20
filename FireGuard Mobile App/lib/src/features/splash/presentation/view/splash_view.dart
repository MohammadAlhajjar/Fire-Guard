import 'package:fire_guard_app/core/resource/constants_manager.dart';
import 'package:fire_guard_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:fire_guard_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/widgets/app_logo_and_name_widget.dart';
import '../../../auth/presentation/view/sign_in_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    sharedPreferences.clear();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  sharedPreferences.getString(ConstantsManager.tokenKey) != null
                      ? const AppBottomNavigationBar()
                      : const SignInView(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      body: Center(
        child: Container(
          width: 222,
          height: 222,
          decoration: const BoxDecoration(
            color: ColorsManager.secondaryColor,
            shape: BoxShape.circle,
          ),
          child: const AppLogoAndNameWidget(),
        ),
      ),
    );
  }
}
