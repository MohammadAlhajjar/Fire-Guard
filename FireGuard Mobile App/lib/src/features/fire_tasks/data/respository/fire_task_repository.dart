// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fire_guard_app/core/error/fauilers.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_location_model.dart';

import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_task_service.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/fire_location_view.dart';

import '../../../../../core/helper/headers_helper.dart';
import '../models/fire_task_model.dart';

abstract class FireTaskRepo {
  Future<Either<Failure, List<FireTask>>> getAllFireTasks();
  Future<Either<Failure, List<FireLocationOrHistoryModel>>>
      getAllFireTasksForHistory();
}

class FireTaskRepoImpl implements FireTaskRepo {
  InternetConnectionInfo internetConnectionInfo;
  FireTaskService fireTaskService;
  FireTaskRepoImpl({
    required this.internetConnectionInfo,
    required this.fireTaskService,
  });

  int fireBrigadeId = 1;

  @override
  Future<Either<Failure, List<FireTask>>> getAllFireTasks() async {
    try {
      if (await internetConnectionInfo.isConnected) {
        try {
          final response = await Dio().get(
            'https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigades/profile',
            options: Options(
              headers: HeadersHepler.getHeader(),
            ),
          );
          print(response.data['data']['fireBrigades']);
          var result = await fireTaskService.getAllFireTasks(
              status: FireStatus.ONFIRE.name,
              fireBrigadeId: response.data['data']['fireBrigades']['id']);
          List<FireTask> fireTask = List.generate(
            result.length,
            (index) => FireTask.fromMap(
              result[index],
            ),
          );
          return Right(fireTask);
        } on Exception catch (e) {
          print('-------<<Exception: $e>>---------------------------');
          return Left(ServerFailure());
        }
      } else {
        return Left(OfflineFailure());
      }
    } on Exception catch (e) {
      print('-------<<Exception: $e>>---------------------------');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FireLocationOrHistoryModel>>>
      getAllFireTasksForHistory() async {
    try {
      if (await internetConnectionInfo.isConnected) {
        try {
          final response = await Dio().get(
            'https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigades/profile',
            options: Options(
              headers: HeadersHepler.getHeader(),
            ),
          );
          print(response.data['data']['fireBrigades']);
          var result = await fireTaskService.getAllFireTasksForHistory(
            fireBrigadeId: response.data['data']['fireBrigades']['id'],
          );

          List<FireLocationOrHistoryModel> fireTasks = List.generate(
            result.length,
            (index) => FireLocationOrHistoryModel.fromMap(
              result[index],
            ),
          );
          return Right(fireTasks);
        } on Exception catch (e) {
          print('-------<<Exception: $e>>---------------------------');
          return Left(ServerFailure());
        }
      } else {
        return Left(OfflineFailure());
      }
    } on Exception catch (e) {
      print('-------<<Exception: $e>>---------------------------');
      return Left(ServerFailure());
    }
  }
}
