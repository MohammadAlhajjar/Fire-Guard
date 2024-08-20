import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/home_view.dart';
import 'package:fire_guard_app/src/features/history/presentation/history_view.dart';
import 'package:fire_guard_app/src/features/profile/presentation/view/profile_view.dart';
import 'package:fire_guard_app/src/features/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int selectedDestinationIndex = 0;
  List<Widget> views = [
    const HomeView(),
    const HistoryView(),
    const ProfileView(),
    const SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsManager.whiteColor,
        shape: const CircleBorder(),
        onPressed: () {},
        child: Text(
          'SOS',
          style: StylesManager.interFontFamilyBold(
            fontSize: 21,
            color: ColorsManager.primaryColor,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: NavigationBar(
        indicatorShape: const CircleBorder(),
        indicatorColor: ColorsManager.indicatorColor,
        backgroundColor: ColorsManager.primaryColor,
        onDestinationSelected: (newDestinationIndex) {
          selectedDestinationIndex = newDestinationIndex;
          setState(() {});
        },
        selectedIndex: selectedDestinationIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: ColorsManager.whiteColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history,
              color: ColorsManager.whiteColor,
            ),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              color: ColorsManager.whiteColor,
            ),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
              color: ColorsManager.whiteColor,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: views[selectedDestinationIndex],
    );
  }
}
