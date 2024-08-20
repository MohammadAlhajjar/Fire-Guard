import 'pages/dash_board_page.dart';
import 'pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const FireGuardDashBoard());
}

void setWindowTitle(String s) {}

class FireGuardDashBoard extends StatelessWidget {
  const FireGuardDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireGaurd',
      debugShowCheckedModeBanner: false,
      home: sharedPreferences.getString('token') != null
          ? const DashboardPage()
          : const LoginPage(),
    );
  }
}
