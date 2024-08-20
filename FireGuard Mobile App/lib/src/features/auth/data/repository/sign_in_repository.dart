// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fire_guard_app/core/error/exceptions.dart';
import 'package:fire_guard_app/core/error/fauilers.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/src/features/auth/data/model/sign_in_model.dart';
import 'package:fire_guard_app/src/features/auth/data/service/sign_in_service.dart';

import '../../../../../core/config/di.dart';
import '../../../../../core/resource/constants_manager.dart';

abstract class SignInRepo {
  Future<Either<Failure, Unit>> signIn(SignInModel signInModel);
}

class SignInRepoImpl implements SignInRepo {
  InternetConnectionInfo internetConnectionInfo;
  SignInService signInService;
  SharedPreferences sharedPreferences;
  SignInRepoImpl({
    required this.internetConnectionInfo,
    required this.signInService,
    required this.sharedPreferences,
  });
  @override
  Future<Either<Failure, Unit>> signIn(SignInModel signInModel) async {
    try {
      if (await internetConnectionInfo.isConnected) {
        print('==============================');
        var signInResponse = await signInService.signIn(signInModel);
        try {
          sharedPreferences.setString(
            ConstantsManager.tokenKey,
            signInResponse[ConstantsManager.tokenKey],
          );
          sharedPreferences.setString(
            ConstantsManager.refreshTokenKey,
            signInResponse[ConstantsManager.refreshTokenKey],
          );
          return const Right(unit);
        } catch (e) {
          print("------------------<<Exception is $e");
          return Left(ServerFailure());
        }
      } else {
        return Left(OfflineFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
