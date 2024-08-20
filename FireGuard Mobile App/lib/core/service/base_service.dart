import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/resource/url_manager.dart';

abstract class BaseService {
  final Dio dio;
  final String baseUrl = UrlManager.baseUrl;
  late Response response;

  BaseService({required this.dio});
}
