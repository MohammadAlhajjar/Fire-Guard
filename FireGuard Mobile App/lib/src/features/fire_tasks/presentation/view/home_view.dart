import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/helper/date_format_helper.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/images_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/src/features/auth/presentation/widgets/sign_in_header.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_node_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_station_center_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_task_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_node_service.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_station_center_service.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_task_service.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/blocs/fire_station_center_details_bloc/fire_station_center_details_and_fire_nodes_bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/fire_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/helper/headers_helper.dart';
import '../../../../../core/resource/constants_manager.dart';
import '../blocs/fire_tasks_bloc/fire_tasks_bloc.dart';

// MapController mapController = MapController();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LatLng fireTruckLatLng = const LatLng(100, 200);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FireTasksBloc(
            fireTaskRepo: FireTaskRepoImpl(
              internetConnectionInfo: InternetConnectionInfo(
                internetConnectionChecker: InternetConnectionChecker(),
              ),
              fireTaskService: FireTaskService(
                dio: Dio(),
              ),
            ),
          )..add(
              GetAllFireTasks(),
            ),
        ),
        BlocProvider(
          create: (_) => FireStationCenterDetailsAndFireNodesBloc(
            fireStationCenterRepo: FireStationCenterRepoImpl(
              internetConnectionInfo: InternetConnectionInfo(
                internetConnectionChecker: InternetConnectionChecker(),
              ),
              fireStationCenterService: FireStationCenterService(
                dio: Dio(),
              ),
            ),
            fireNodeRepo: FireNodeRepoImpl(
              internetConnectionInfo: InternetConnectionInfo(
                internetConnectionChecker: InternetConnectionChecker(),
              ),
              fireNodeService: FireNodeService(
                dio: Dio(),
              ),
            ),
          )..add(
              GetFireStationCenterDetailsAndFireNodes(),
            ),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              const Gap(60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const WelcomeHeader(
                      fontSize: 20,
                      imageSize: 17,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<FireTasksBloc>()
                                .add(GetAllFireTasks());
                            context
                                .read<
                                    FireStationCenterDetailsAndFireNodesBloc>()
                                .add(GetFireStationCenterDetailsAndFireNodes());
                          },
                          child: const Icon(
                            Icons.refresh,
                            color: ColorsManager.blackColor,
                          ),
                        ),
                        const Icon(
                          Icons.notifications_outlined,
                          color: ColorsManager.blackColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(30),
              SizedBox(
                height: screenHeight / 2.14,
                width: double.infinity,
                child: BlocBuilder<FireStationCenterDetailsAndFireNodesBloc,
                    FireStationCenterDetailsState>(
                  builder: (context, state) {
                    if (state is FireStationCenterSuccess) {
                      fireTruckLatLng = LatLng(
                        double.parse(
                            state.fireStationCentersDetails[0].latitude!),
                        double.parse(
                          state.fireStationCentersDetails[0].longitude!,
                        ),
                      );

                      return FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(
                            double.parse(
                              state.fireStationCentersDetails[0].latitude!,
                            ),
                            double.parse(
                              state.fireStationCentersDetails[0].longitude!,
                            ),
                          ),
                          initialZoom: 10,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: ConstantsManager.flutterMapUrlTemplate,
                            userAgentPackageName:
                                ConstantsManager.userAgentPackageName,
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                  double.parse(
                                    state
                                        .fireStationCentersDetails[0].latitude!,
                                  ),
                                  double.parse(
                                    state.fireStationCentersDetails[0]
                                        .longitude!,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.apartment,
                                  color: ColorsManager.primaryColor,
                                  size: 40,
                                ),
                              ),
                              ...List.generate(state.fireNodes.length, (index) {
                                return Marker(
                                  point: LatLng(
                                    double.parse(
                                        state.fireNodes[index].latitude!),
                                    double.parse(
                                        state.fireNodes[index].latitude!),
                                  ),
                                  child: const Icon(
                                    Icons.speed,
                                    color: ColorsManager.primaryColor,
                                    size: 40,
                                  ),
                                );
                              })
                            ],
                          ),
                        ],
                      );
                    } else if (state is FireStationCenterDetailsFailure) {
                      return Center(
                        child: Text(
                          'Server problem, Please try again later . . .',
                          style: StylesManager.interFontFamilyBold(
                            fontSize: 14,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.primaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                height: screenHeight / 3.5,
                decoration: const BoxDecoration(
                  color: ColorsManager.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(29),
                      Text(
                        'Tasks',
                        style: StylesManager.interFontFamilyBold(
                          fontSize: 16,
                          color: ColorsManager.blackColor,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<FireTasksBloc, FireTasksState>(
                          builder: (context, state) {
                            if (state is FireTasksSuccess) {
                              if (state.fireTasks.isEmpty) {
                                return const NoTaskWidget();
                              }
                              return ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                                itemCount: state.fireTasks.length,
                                itemBuilder: (context, index) {
                                  return FireAlertItem(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FireLocationView(
                                            fireTask: state.fireTasks[index],
                                            fireTruckLatLng: fireTruckLatLng,
                                          ),
                                        ),
                                      );
                                    },
                                    fireCreatesAt:
                                        DateFormatHelper.getFormattedDate(state
                                            .fireTasks[index].fire!.createsAt!),
                                  );
                                },
                              );
                            } else if (state is FireTasksFailure) {
                              return Center(
                                child: Text(
                                  'Server problem, Please try again later . . .',
                                  style: StylesManager.interFontFamilyBold(
                                    fontSize: 14,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: ColorsManager.primaryColor,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class FireAlertItem extends StatelessWidget {
  const FireAlertItem({
    super.key,
    this.hasStatus = false,
    required this.fireCreatesAt,
    this.onPressed,
    this.status,
    this.statusColor,
  });
  final String? status;
  final bool hasStatus;
  final String fireCreatesAt;
  final VoidCallback? onPressed;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        border: Border.all(
          color: ColorsManager.borderColor,
        ),
      ),
      child: ListTile(
        onTap: onPressed,
        leading: const FlameConatiner(),
        title: Text(
          'Fire Alert',
          style: StylesManager.interFontFamilyBold(
            fontSize: 16,
            color: ColorsManager.blackColor,
          ),
        ),
        subtitle: Text(
          fireCreatesAt,
          style: StylesManager.interFontFamilyMedium(
            fontSize: 10,
            color: ColorsManager.subtitleGrayColor,
          ),
        ),
        trailing: hasStatus
            ? Container(
                width: 85,
                height: 25,
                decoration: BoxDecoration(
                  color: status == FireStatus.CANCELED.name
                      ? ColorsManager.primaryColor.withOpacity(0.4)
                      : ColorsManager.backgroundGreenColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    status ?? "Status",
                    style: StylesManager.interFontFamilyBold(
                      fontSize: 10,
                      color: status == FireStatus.CANCELED.name
                          ? ColorsManager.primaryColor
                          : ColorsManager.greenColor,
                    ),
                  ),
                ),
              )
            : SvgPicture.asset(ImagesManager.arrowForwardVectorSvg),
      ),
    );
  }
}

class FlameConatiner extends StatelessWidget {
  const FlameConatiner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorsManager.primaryColor,
      child: SvgPicture.asset(
        height: 26,
        ImagesManager.flameVectorSvg,
      ),
    );
  }
}

class NoTaskWidget extends StatelessWidget {
  const NoTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Tasks !',
              style: StylesManager.interFontFamilyRegular(
                fontSize: 20,
                color: ColorsManager.blackColor.withOpacity(
                  0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
