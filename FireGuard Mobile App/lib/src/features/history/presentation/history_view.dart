import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/helper/date_format_helper.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/images_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_task_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_task_service.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/blocs/fire_tasks_history_bloc/fire_tasks_history_bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/fire_location_view.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => FireTasksHistoryBloc(
        fireTaskRepo: FireTaskRepoImpl(
          internetConnectionInfo: InternetConnectionInfo(
            internetConnectionChecker: InternetConnectionChecker(),
          ),
          fireTaskService: FireTaskService(
            dio: Dio(),
          ),
        ),
      )..add(
          GetAllFireTasksHistory(),
        ),
      child: Scaffold(
        body: Column(
          children: [
            const Gap(60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My History',
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight / 5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        ImagesManager.historyHeaderImage,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: const Alignment(-0.8, 0.6),
                  width: double.infinity,
                  height: screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        ColorsManager.blackColor.withOpacity(0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    'All Fire Alerts History',
                    style: StylesManager.interFontFamilyBold(
                      fontSize: 16,
                      color: ColorsManager.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 1.78,
              child: BlocBuilder<FireTasksHistoryBloc, FireTasksHistoryState>(
                builder: (context, state) {
                  if (state is FireTasksHistorySuccess) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      itemCount: state.fireTasksHistory.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemBuilder: (context, index) {
                        print('==============test bool============');
                        print(
                            state.fireTasksHistory[index].status == 'CANCELED');
                        print(
                          state.fireTasksHistory[index],
                        );
                        return FireAlertItem(
                          status: state.fireTasksHistory[index].status!,
                          hasStatus: true,
                          fireCreatesAt: DateFormatHelper.getFormattedDate(
                              state.fireTasksHistory[index].createdAt!),
                        );
                      },
                    );
                  } else if (state is FireTasksHistoryFailure) {
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
            ),
          ],
        ),
      ),
    );
  }
}
