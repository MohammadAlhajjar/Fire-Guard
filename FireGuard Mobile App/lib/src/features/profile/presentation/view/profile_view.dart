import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/images_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/src/features/profile/data/repository/profile_repository.dart';
import 'package:fire_guard_app/src/features/profile/data/service/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../profile_bloc/profile_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => ProfileBloc(
        profileRepository: ProfileRepositoryImpl(
          internetConnectionInfo: InternetConnectionInfo(
            internetConnectionChecker: InternetConnectionChecker(),
          ),
          profileService: ProfileService(
            dio: Dio(),
          ),
        ),
      )..add(GetFireBrigadeProfile()),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Image.asset(
                width: double.infinity,
                height: screenHeight / 3.4,
                fit: BoxFit.fill,
                ImagesManager.profileHeaderImage,
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileSuccess) {
                          return Column(
                            children: [
                              const Gap(30),
                              Container(
                                width: 175,
                                height: 175,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      ImagesManager.profileImage,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsManager.primaryColor
                                          .withOpacity(0.5),
                                      offset: const Offset(10, 15),
                                      blurRadius: 10,
                                      spreadRadius: 0.1,
                                    ),
                                  ],
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Gap(30),
                              Text(
                                state.fireBrigadePofileModel.name!
                                    .toUpperCase(),
                                style: StylesManager.interFontFamilyBold(
                                  fontSize: 24,
                                  color: ColorsManager.blackColor,
                                ),
                              ),
                              const Gap(40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email: ${state.fireBrigadePofileModel.email}',
                                    style: StylesManager.interFontFamilyMedium(
                                      fontSize: 18,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),
                                  const Gap(20),
                                  Text(
                                    'Number Of Team: ${state.fireBrigadePofileModel.numberOfTeam}',
                                    style: StylesManager.interFontFamilyMedium(
                                      fontSize: 18,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),
                                  const Gap(20),
                                  Text(
                                    'Center Name: ${state.fireBrigadePofileModel.center!.name}',
                                    style: StylesManager.interFontFamilyMedium(
                                      fontSize: 18,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (state is ProfileFailure) {
                          return Center(
                            child: Text(
                              'Server problem, Please try again later . . .',
                              style: StylesManager.interFontFamilyBold(
                                fontSize: 16,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// {
//   "success": true,
//   "data": {
//     "fireBrigades": {
//       "center": {
//         "id": 1,
//         "name": "Al Hamra",
//         "createdAt": "2024-06-21T20:37:56+00:00"
//       },
//       "id": 1,
//       "name": "fire brigade Al Hamr",
//       "email": "test@test.com",
//       "numberOfTeam": 10,
//       "createdAt": "2024-06-21T20:39:29+00:00",
//       "updatedAt": "2024-06-21T20:39:29+00:00"
//     }
//   }
// }