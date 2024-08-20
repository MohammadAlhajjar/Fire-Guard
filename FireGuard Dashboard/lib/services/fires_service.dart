import 'dart:convert';

import '../main.dart';
import '../models/fire_model.dart';
import 'package:http/http.dart' as http;

Future<List<FireModel>> fetchFireData() async {
  final response = await http.get(
    Uri.parse('https://firegard.cupcoding.com/backend/public/api/admin/fires'),
    headers: {
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
    },
  );
  print('=========================');
  print(response.body);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return (data['pagination']['items'] as List)
        .map((fire) => FireModel.fromMap(fire))
        .toList();
  } else {
    throw Exception('Failed to load fires');
  }
}
