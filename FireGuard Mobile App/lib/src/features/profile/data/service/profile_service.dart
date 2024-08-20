import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/error/exceptions.dart';
import 'package:fire_guard_app/core/helper/headers_helper.dart';
import 'package:fire_guard_app/core/resource/url_manager.dart';
import 'package:fire_guard_app/core/service/base_service.dart';

class ProfileService extends BaseService {
  ProfileService({required super.dio});

  Future<Map<String, dynamic>> getFireBrigadeProfile() async {
    response = await dio.get(
      '$baseUrl/${UrlManager.mobileProfileEndpoint}',
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );
    print(response.data['data']['fireBrigades']);
    if (response.statusCode == 200) {
      return response.data['data']['fireBrigades'];
    } else {
      throw ServerException();
    }
  }
}
