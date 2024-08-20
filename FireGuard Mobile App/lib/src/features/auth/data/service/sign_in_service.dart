import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/config/di.dart';
import 'package:fire_guard_app/core/error/exceptions.dart';
import 'package:fire_guard_app/core/resource/constants_manager.dart';
import 'package:fire_guard_app/core/resource/url_manager.dart';
import 'package:fire_guard_app/core/service/base_service.dart';
import 'package:fire_guard_app/src/features/auth/data/model/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInService extends BaseService {
  SignInService({required super.dio});

  Future<dynamic> signIn(SignInModel signInModel) async {
    try {
      response = await dio.post(
        "$baseUrl/${UrlManager.mobileLoginEndpoint}",
        data: signInModel.toMap(),
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on Exception catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
