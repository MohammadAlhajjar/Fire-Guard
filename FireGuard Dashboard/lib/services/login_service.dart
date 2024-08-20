import 'dart:convert';

import 'package:http/http.dart' as http;

String loginEndPoint =
    'https://firegard.cupcoding.com/backend/public/api/admin/login';

Future<http.Response> login(String username, String password) async {
  return http.post(
    Uri.parse(
      loginEndPoint,
    ),
    body: json.encode(
      {
        'username': username,
        'password': password,
      },
    ),
  );
}
