// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/sos_request_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/update_fire_status_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_location_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_location_service.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/blocs/sos_bloc/sos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';

import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/constants_manager.dart';
import 'package:fire_guard_app/core/resource/images_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/home_view.dart';

import '../../../../../core/network/network_connection_info.dart';
import '../../data/models/fire_task_model.dart';
import '../blocs/fire_location_bloc/fire_location_bloc.dart';
import '../blocs/update_fire__status_bloc/update_fire_status_bloc.dart';

class FireLocationView extends StatefulWidget {
  const FireLocationView({
    super.key,
    required this.fireTask,
    required this.fireTruckLatLng,
  });
  final FireTask fireTask;
  final LatLng fireTruckLatLng;
  @override
  State<FireLocationView> createState() => _FireLocationViewState();
}

enum FireStatus {
  COMPLETED,
  ONFIRE,
  INPROGRESS,
  CANCELED,
  DANGEROUS,
}

class _FireLocationViewState extends State<FireLocationView> {
  int? centerId = 0;
  @override
  void initState() {
    super.initState();
  }

  bool isTaskCompleted = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateFireStatusBloc()
            ..add(
              InitialStateRequest(),
            ),
        ),
        BlocProvider(
          create: (context) => FireLocationBloc(
            fireLocationRepo: FireLocationRepoImpl(
              internetConnectionInfo: InternetConnectionInfo(
                internetConnectionChecker: InternetConnectionChecker(),
              ),
              fireLocationService: FireLocationService(
                dio: Dio(),
              ),
            ),
          )..add(
              GetFireLocation(fireId: widget.fireTask.id!),
            ),
        ),
        BlocProvider(
          create: (context) => SosBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorsManager.primaryColor,
            shape: const CircleBorder(),
            onPressed: () {
              context.read<SosBloc>().add(
                    SendSosRequestEvent(
                      sosRequestMdoel: SosRequestMdoel(
                        fire: widget.fireTask.fire!.id!.toString(),
                        fireBrigade: widget.fireTask.fireBrigade!.id.toString(),
                        status: FireStatus.DANGEROUS.name,
                      ),
                    ),
                  );
            },
            child: Text(
              'SOS',
              style: StylesManager.interFontFamilyBold(
                fontSize: 21,
                color: ColorsManager.whiteColor,
              ),
            ),
          ),
          backgroundColor: ColorsManager.whiteColor,
          body: BlocBuilder<FireLocationBloc, FireLocationState>(
            builder: (context, state) {
              if (state is FireLocationSuccess) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight / 1.5,
                      child: Stack(
                        children: [
                          FlutterMap(
                            options: MapOptions(
                              initialCenter: widget.fireTruckLatLng,
                              initialZoom: 12,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    ConstantsManager.flutterMapUrlTemplate,
                                userAgentPackageName:
                                    ConstantsManager.userAgentPackageName,
                              ),
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: [
                                      widget.fireTruckLatLng,
                                      LatLng(
                                        double.parse(
                                          state.fireLocationModel.fire!
                                              .latitude!,
                                        ),
                                        double.parse(state.fireLocationModel
                                            .fire!.longitude!),
                                      ),
                                    ],
                                    color: ColorsManager.blackColor
                                        .withOpacity(0.7),
                                    strokeWidth: 2,
                                  )
                                ],
                              ),
                              MarkerLayer(
                                markers: [
                                  // ! correct
                                  Marker(
                                    point: widget.fireTruckLatLng,
                                    child: const Icon(
                                      Icons.fire_truck,
                                      color: ColorsManager.primaryColor,
                                      size: 40,
                                    ),
                                  ),
                                  // ! wrong must be fire location
                                  Marker(
                                    // point: LatLng(36.93928, 34.5181714),
                                    point: LatLng(
                                      double.parse(
                                        state.fireLocationModel.fire!.latitude!,
                                      ),
                                      double.parse(state
                                          .fireLocationModel.fire!.longitude!),
                                    ),
                                    child: const Icon(
                                      Icons.local_fire_department,
                                      color: ColorsManager.primaryColor,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: const Alignment(-0.88, -0.8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: ColorsManager.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      12,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    height: 16,
                                    ImagesManager.arrowBackwardVectorSvg,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const FlameConatiner(),
                              const Gap(17),
                              Text(
                                'Fire Alert',
                                style: StylesManager.interFontFamilyBold(
                                  fontSize: 16,
                                  color: ColorsManager.blackColor,
                                ),
                              ),
                              BlocListener<SosBloc, SosState>(
                                listener: (context, state) {
                                  if (state is SosSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            ColorsManager.primaryColor,
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          'SOS request was sent....',
                                          style:
                                              StylesManager.interFontFamilyBold(
                                            fontSize: 15,
                                            color: ColorsManager.whiteColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Spacer(),
                              ),
                              BlocListener<UpdateFireStatusBloc,
                                  UpdateFireStatusState>(
                                listener: (context, state) {
                                  if (state is UpdateFireStatusSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            state.fireModel.status ==
                                                    FireStatus.COMPLETED.name
                                                ? ColorsManager.greenColor
                                                : ColorsManager.primaryColor,
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          'Task status was updated',
                                          style:
                                              StylesManager.interFontFamilyBold(
                                            fontSize: 15,
                                            color: ColorsManager.whiteColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: isTaskCompleted
                                    ? null
                                    : OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: ColorsManager.primaryColor,
                                          ),
                                          minimumSize:
                                              Size(screenWidth / 2.8, 40),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (_) {
                                              return BlocProvider.value(
                                                value: BlocProvider.of<
                                                        UpdateFireStatusBloc>(
                                                    context),
                                                child: AlertDialog(
                                                  icon: const Icon(
                                                    Icons.warning,
                                                    size: 55,
                                                  ),
                                                  iconColor: ColorsManager
                                                      .primaryColor,
                                                  backgroundColor:
                                                      ColorsManager.whiteColor,
                                                  surfaceTintColor:
                                                      ColorsManager.whiteColor,
                                                  titleTextStyle: StylesManager
                                                      .interFontFamilyMedium(
                                                    fontSize: 18,
                                                    color: ColorsManager
                                                        .blackColor,
                                                  ),
                                                  title: const Text(
                                                    'Are you sure you want to cancel this task ?',
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorsManager
                                                                .primaryColor,
                                                        foregroundColor:
                                                            ColorsManager
                                                                .whiteColor,
                                                      ),
                                                      onPressed: () async {
                                                        context
                                                            .read<
                                                                UpdateFireStatusBloc>()
                                                            .add(
                                                              UpdateFireStatus(
                                                                widget.fireTask
                                                                    .id!
                                                                    .toString(),
                                                                fireStatusModel:
                                                                    UpdateFireStatusModel(
                                                                  status:
                                                                      FireStatus
                                                                          .CANCELED
                                                                          .name,
                                                                ),
                                                              ),
                                                            );
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return const AppBottomNavigationBar();
                                                              },
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Yes',
                                                      ),
                                                    ),
                                                    OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                              foregroundColor:
                                                                  ColorsManager
                                                                      .primaryColor,
                                                              side:
                                                                  const BorderSide(
                                                                color: ColorsManager
                                                                    .primaryColor,
                                                              )),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        'No',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Cancel Task',
                                          style: StylesManager
                                              .interFontFamilyMedium(
                                            fontSize: 14,
                                            color: ColorsManager.primaryColor,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const Gap(26.5),
                          const FirePointLocation(
                            pointCarachter: 'A Point:',
                            pointNameLocation: 'Fire Station Location',
                            pointIcon: Icons.fire_truck,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            height: screenHeight / 17,
                            child: const VerticalDivider(
                              thickness: 2,
                              indent: 0.5,
                              endIndent: 0.5,
                              color: ColorsManager.blackColor,
                            ),
                          ),
                          const FirePointLocation(
                            pointIcon: Icons.whatshot,
                            pointCarachter: 'B Point:',
                            pointNameLocation: 'Fire Location',
                          ),
                          const Gap(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<UpdateFireStatusBloc,
                                  UpdateFireStatusState>(
                                builder: (context, state) {
                                  if (state is UpdateFireStatusInitial) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(screenWidth / 2, 50),
                                        backgroundColor:
                                            ColorsManager.primaryColor,
                                        foregroundColor:
                                            ColorsManager.whiteColor,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<UpdateFireStatusBloc>()
                                            .add(
                                              UpdateFireStatus(
                                                widget.fireTask.id.toString(),
                                                fireStatusModel:
                                                    UpdateFireStatusModel(
                                                  status: FireStatus
                                                      .INPROGRESS.name,
                                                ),
                                              ),
                                            );
                                      },
                                      child: Text(
                                        'Accept Task',
                                        style:
                                            StylesManager.interFontFamilyBold(
                                          fontSize: 18,
                                          color: ColorsManager.whiteColor,
                                        ),
                                      ),
                                    );
                                  } else if (state is UpdateFireStatusSuccess) {
                                    if (state.fireModel.status ==
                                        FireStatus.INPROGRESS.name) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              Size(screenWidth / 2, 50),
                                          backgroundColor: const Color.fromARGB(
                                              255, 25, 180, 40),
                                          foregroundColor:
                                              ColorsManager.whiteColor,
                                        ),
                                        onPressed: () {
                                          isTaskCompleted = true;
                                          context
                                              .read<UpdateFireStatusBloc>()
                                              .add(
                                                UpdateFireStatus(
                                                  widget.fireTask.id.toString(),
                                                  fireStatusModel:
                                                      UpdateFireStatusModel(
                                                    status: FireStatus
                                                        .COMPLETED.name,
                                                  ),
                                                ),
                                              );
                                        },
                                        child: Text(
                                          'Task Complete',
                                          style:
                                              StylesManager.interFontFamilyBold(
                                            fontSize: 18,
                                            color: ColorsManager.whiteColor,
                                          ),
                                        ),
                                      );
                                    }
                                    //  else if (state.fireModel.status!.value ==
                                    //     FireStatus.COMPLETED.name) {
                                    //   return Container();
                                    // }
                                    else {
                                      return Container();
                                      // return ElevatedButton(
                                      //   style: ElevatedButton.styleFrom(
                                      //     minimumSize:
                                      //         Size(screenWidth / 2, 50),
                                      //     backgroundColor:
                                      //         ColorsManager.primaryColor,
                                      //     foregroundColor:
                                      //         ColorsManager.whiteColor,
                                      //   ),
                                      //   onPressed: () {
                                      //     context
                                      //         .read<UpdateFireStatusBloc>()
                                      //         .add(
                                      //           UpdateFireStatus(
                                      //             widget.fireTask.id!
                                      //                 .toString(),
                                      //             fireStatusModel:
                                      //                 UpdateFireStatusModel(
                                      //               status: FireStatus
                                      //                   .INPROGRESS.name,
                                      //             ),
                                      //           ),
                                      //         );
                                      //   },
                                      //   child: Text(
                                      //     'Accept Task',
                                      //     style:
                                      //         StylesManager.interFontFamilyBold(
                                      //       fontSize: 18,
                                      //       color: ColorsManager.whiteColor,
                                      //     ),
                                      //   ),
                                      // );
                                    }
                                  } else if (state is UpdateFireStatusLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.primaryColor,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is FireLocationFailure) {
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
        );
      }),
    );
  }
}

class FirePointLocation extends StatelessWidget {
  const FirePointLocation({
    super.key,
    required this.pointCarachter,
    required this.pointNameLocation,
    required this.pointIcon,
  });
  final String pointCarachter;
  final String pointNameLocation;
  final IconData pointIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 15,
          backgroundColor: ColorsManager.primaryColor,
          child: Icon(
            pointIcon,
            color: ColorsManager.whiteColor,
          ),
        ),
        const Gap(10),
        Text(pointCarachter),
        const Spacer(),
        Text(pointNameLocation)
      ],
    );
  }
}
