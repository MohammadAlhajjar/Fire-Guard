import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/src/features/settings/presentation/view/settings_view.dart';
import 'package:fire_guard_app/src/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireGuardApp extends StatelessWidget {
  const FireGuardApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            color: ColorsManager.whiteColor,
          ),
        ),
      )),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
