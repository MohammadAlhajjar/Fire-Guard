import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/helper/headers_helper.dart';
import '../../../../../core/resource/url_manager.dart';
import '../../../../../core/service/base_service.dart';

class FireNodeService extends BaseService {
  FireNodeService({required super.dio});

  Future<List<dynamic>> getFireNodes() async {
    response = await dio.get(
      // '$baseUrl/${UrlManager.mobileFireNodesEndpoint}',
      'https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigade/devices',
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );
    print(response.data['pagination']['items']);
    if (response.statusCode == 200) {
      return response.data['pagination']['items'];
    } else {
      throw ServerException();
    }
  }
}
