import 'package:dio/dio.dart';

import 'package:fire_guard_app/core/error/exceptions.dart';
import 'package:fire_guard_app/core/helper/headers_helper.dart';

import 'package:fire_guard_app/core/resource/url_manager.dart';
import 'package:fire_guard_app/core/service/base_service.dart';

class FireTaskService extends BaseService {
  FireTaskService({required super.dio});

  Future<List<dynamic>> getAllFireTasks({String? status, int? fireBrigadeId}) async {
    response = await dio.get(
      '$baseUrl/${UrlManager.mobileFireTasksEndpoint}?status=$status&fireBrigade=$fireBrigadeId',
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return response.data['pagination']['items'];
    } else {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getAllFireTasksForHistory(
      {required int fireBrigadeId}) async {
    response = await dio.get(
      '$baseUrl/${UrlManager.mobileFireTasksEndpoint}?fireBrigade=$fireBrigadeId',
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );
    print('==========================test print====================');
    print(response.data);
    if (response.statusCode == 200) {
      return response.data['pagination']['items'];
    } else {
      throw ServerException();
    }
  }
}
