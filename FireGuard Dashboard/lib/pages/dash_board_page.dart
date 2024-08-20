import '../blocs/center_bloc/center_bloc.dart';
import '../blocs/fire_brigade_bloc/fire_brigade_bloc.dart';
import '../blocs/forest_bloc/forest_bloc.dart';
import '../blocs/task_fire_brigades_bloc/task_fire_brigades_bloc.dart';
import '../core/colors.dart';
import '../main.dart';
import 'centers_page.dart';
import 'devices_page.dart';
import 'fire_brigades_page.dart';
import 'fires_page.dart';
import 'forest_page.dart';
import 'history_page.dart';
import 'login_page.dart';
import 'map_and_locations.dart';
import 'task_fire_brigades_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/car_bloc/car_bloc.dart';
import '../blocs/device_bloc/device_bloc.dart';
import 'cars_page.dart';
import 'device_value_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> pages = [
    {
      'title': 'Map',
      'page': const MapAndLocationsPage(),
    },
    {
      'title': 'Fires',
      'page': const FireGridPage(),
    },
    {
      'title': 'Task Fire Brigades',
      'page': BlocProvider(
        create: (context) => TaskFireBrigadesBloc()
          ..add(
            FetchTaskFireBrigades(),
          ),
        child: const TaskFireBrigadePage(),
      ),
    },
    {
      'title': 'Fire Brigades',
      'page': BlocProvider(
        create: (context) => FireBrigadeBloc()
          ..add(
            FetchFireBrigades(),
          ),
        child: const FireBrigadesPage(),
      ),
    },
    {
      'title': 'Device Values',
      'page': const DeviceValuesPage(),
    },
    {
      'title': 'Forests',
      'page': BlocProvider(
        create: (context) => ForestBloc()..add(FetchForests()),
        child: const ForestsPage(),
      ),
    },
    {
      'title': 'Centers',
      'page': BlocProvider(
        create: (context) => CenterBloc()..add(FetchCenters()),
        child: const CentersPage(),
      ),
    },
    {
      'title': 'Devices',
      'page': BlocProvider(
        create: (context) => DeviceBloc()..add(FetchDevices()),
        child: const DevicesPage(),
      ),
    },
    {
      'title': 'Cars',
      'page': BlocProvider(
        create: (context) => CarBloc()..add(FetchCars()),
        child: const CarsPage(),
      ),
    },
    {
      'title': 'History',
      'page': BlocProvider(
        create: (context) => TaskFireBrigadesBloc()
          ..add(
            FetchTaskFireBrigades(),
          ),
        child: const HistoryPage(),
      ),
    },
    {
      'title': 'Logout',
      'page': Container(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            width: 265,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.zero,
              ),
            ),
            backgroundColor: const Color(0xff333333),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 26,
                    bottom: 30,
                  ),
                  child: Image.asset(
                    fit: BoxFit.fill,
                    'assets/images/logo.png',
                  ),
                ),
                SizedBox(
                  height: height / 1.24,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      if (pages.length - 2 == index) {
                        return const SizedBox(
                          height: 70,
                        );
                      }
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: index == pages.length - 1
                            ? const Icon(
                                Icons.logout,
                                color: primaryColor,
                              )
                            : null,
                        selected: selectedIndex == index ? true : false,
                        selectedTileColor: primaryColor,
                        selectedColor: Colors.white,
                        textColor: Colors.white,
                        onTap: () {
                          if (index == pages.length - 1) {
                            Future.delayed(const Duration(seconds: 2), () {
                              sharedPreferences.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            });
                          } else {
                            setState(() {
                              selectedIndex = index;
                            });
                          }
                        },
                        title: Text(
                          pages[index]['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                                selectedIndex == index ? FontWeight.w900 : null,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: pages[selectedIndex]['page'],
          ),
        ],
      ),
    );
  }
}
