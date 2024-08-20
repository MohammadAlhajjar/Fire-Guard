// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_node_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_node_service.dart';

import '../../../../../core/error/fauilers.dart';
import '../../../../../core/network/network_connection_info.dart';

abstract class FireNodeRepo {
  Future<Either<Failure, List<FireNodeModel>>> getFireNodes();
}

class FireNodeRepoImpl implements FireNodeRepo {
  InternetConnectionInfo internetConnectionInfo;
  FireNodeService fireNodeService;
  FireNodeRepoImpl({
    required this.internetConnectionInfo,
    required this.fireNodeService,
  });

  @override
  Future<Either<Failure, List<FireNodeModel>>> getFireNodes() async {
    try {
      if (await internetConnectionInfo.isConnected) {
        try {
          var result = await fireNodeService.getFireNodes();
          print("===========================");
          print(result);
          // List<FireNodeModel> fireNodes = List.generate(
          //   result.length,
          //   (index) => FireNodeModel.fromMap(
          //     result[index],
          //   ),
          // );
          print('--------------------------------------------');
          List<FireNodeModel> fireNodes = result.map((fireNode) {
            return FireNodeModel.fromMap(fireNode);
          }).toList();

          print(fireNodes);
          return Right(fireNodes);
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
