// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_station_center_model.dart';

import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_station_center_service.dart';

import '../../../../../core/error/fauilers.dart';
import '../../../../../core/network/network_connection_info.dart';

abstract class FireStationCenterRepo {
  Future<Either<Failure, List<FireStationCenterModel>>> getFireStationCenterDetails();
}

class FireStationCenterRepoImpl implements FireStationCenterRepo {
  InternetConnectionInfo internetConnectionInfo;
  FireStationCenterService fireStationCenterService;
  FireStationCenterRepoImpl({
    required this.internetConnectionInfo,
    required this.fireStationCenterService,
  });

  @override
  Future<Either<Failure, List<FireStationCenterModel>>>
      getFireStationCenterDetails() async {
    try {
      if (await internetConnectionInfo.isConnected) {
        try {
          var result =
              await fireStationCenterService.getFireStationCenterDetails();
          List<FireStationCenterModel> fireStationCentersDetails = List.generate(
            result.length,
            (index) => FireStationCenterModel.fromMap(
              result[index],
            ),
          );
          return Right(fireStationCentersDetails);
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
