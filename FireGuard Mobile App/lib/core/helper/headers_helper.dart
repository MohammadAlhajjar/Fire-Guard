import 'package:fire_guard_app/main.dart';

import '../resource/constants_manager.dart';

class HeadersHepler {
  static Map<String, dynamic> getHeader() {
    return {
      'accept': 'application/json',
      'Authorization':
          'Bearer ${sharedPreferences.getString(ConstantsManager.tokenKey)}',
    };
  }
}
