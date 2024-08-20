// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fire_guard_app/core/error/fauilers.dart';
import 'package:fire_guard_app/src/features/profile/data/model/fire_brigade_profile_model.dart';
import 'package:fire_guard_app/src/features/profile/data/service/profile_service.dart';

import '../../../../../core/network/network_connection_info.dart';

abstract class ProfileRepository {
  Future<Either<Failure, FireBrigadePofileModel>> getFireBrigadeProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  InternetConnectionInfo internetConnectionInfo;
  ProfileService profileService;
  ProfileRepositoryImpl({
    required this.internetConnectionInfo,
    required this.profileService,
  });
  @override
  Future<Either<Failure, FireBrigadePofileModel>>
      getFireBrigadeProfile() async {
    try {
      if (await internetConnectionInfo.isConnected) {
        try {
          Map<String, dynamic> result =
              await profileService.getFireBrigadeProfile();
          FireBrigadePofileModel fireBrigadePofileModel =
              FireBrigadePofileModel.fromMap(result);
          return Right(fireBrigadePofileModel);
        } on DioException catch (e) {
          print(e);
          return Left(ServerFailure());
        }
      } else {
        return Left(OfflineFailure());
      }
    } on Exception catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
