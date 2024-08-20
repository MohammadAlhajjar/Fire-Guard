// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fire_guard_app/main.dart';
import 'package:fire_guard_app/src/features/auth/presentation/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/styles_manager.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isDark = false;
  final List<Widget> settingsItems = [
    ListTile(
      title: const Text('Language'),
      leading: const Icon(Icons.language),
      trailing: DropdownButton<String>(
        items: const [
          DropdownMenuItem(
            child: Text(
              'English',
            ),
          ),
        ],
        onChanged: (Object? value) {},
      ),
    ),
    const ListTile(
      title: Text('Notifications'),
      leading: Icon(Icons.notifications),
    ),
    ListTile(
      title: const Text('Dark Mode'),
      leading: const Icon(Icons.wb_sunny_outlined),
      trailing: Switch(
        activeColor: ColorsManager.primaryColor,
        value: true,
        onChanged: (bool value) {},
      ),
    ),
    const ListTile(
      title: Text('Privacy Policy'),
      leading: Icon(Icons.privacy_tip_outlined),
    ),
    ListTile(
      onTap: () {
        sharedPreferences.clear();
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignInView(),
          ),
        );
      },
      title: Text(
        'Logout',
        style: TextStyle(
          color: ColorsManager.primaryColor,
        ),
      ),
      leading: Icon(
        Icons.logout,
        color: ColorsManager.primaryColor,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Settings',
                  style: StylesManager.interFontFamilyBold(
                    fontSize: 20,
                    color: ColorsManager.blackColor,
                  ),
                ),
                const Icon(
                  Icons.notifications_outlined,
                  color: ColorsManager.blackColor,
                ),
              ],
            ),
          ),
          const Gap(37),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return settingsItems[index];
              },
              separatorBuilder: (context, index) => const Gap(14),
              itemCount: settingsItems.length,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    this.trailing,
    required this.iconData,
  });
  final String title;
  final Widget? trailing;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        iconData,
      ),
      trailing: trailing,
    );
  }
}
