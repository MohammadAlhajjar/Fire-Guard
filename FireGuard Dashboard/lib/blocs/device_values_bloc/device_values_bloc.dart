import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../main.dart';
import '../../models/device_value_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'device_values_event.dart';
part 'device_values_state.dart';

class DeviceValuesBloc extends Bloc<DeviceValuesEvent, DeviceValuesState> {
  DeviceValuesBloc() : super(DeviceValuesInitial()) {
    on<FetchDeviceValues>((event, emit) async {
      emit(DeviceValuesLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/device-values'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          print(data['pagination']['items']);
          List<DeviceValueModel> deviceValues = List.generate(
            data['pagination']['items'].length,
            (index) => DeviceValueModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(DeviceValuesSuccess(deviceValues: deviceValues));
        } else {
          emit(
            DeviceValuesError(
              errorMessage: 'Failed to fetch data',
            ),
          );
        }
      } catch (error) {
        emit(
          DeviceValuesError(
            errorMessage: error.toString(),
          ),
        );
      }
    });
  }
}
