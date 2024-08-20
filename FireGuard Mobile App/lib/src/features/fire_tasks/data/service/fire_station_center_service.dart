import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/helper/headers_helper.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/resource/url_manager.dart';
import '../../../../../core/service/base_service.dart';

class FireStationCenterService extends BaseService {
  FireStationCenterService({required super.dio});

  Future<List<dynamic>> getFireStationCenterDetails() async {
    response = await dio.get(
      '$baseUrl/${UrlManager.mobileFireStationCentersEndpoint}',
      // "https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigade/task-fire-brigades",
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );
    print(response.data['pagination']['items']);
    if (response.statusCode == 200) {
      // print(response.data['data']);
      return response.data['pagination']['items'];
    } else {
      throw ServerException();
    }
  }
}
