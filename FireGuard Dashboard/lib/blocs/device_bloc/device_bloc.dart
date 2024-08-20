import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import '../../models/device_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../models/create_device_model.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(DeviceInitial()) {
    on<FetchDevices>((event, emit) async {
      emit(DeviceLoading());
      try {
        final response = await http.get(
          Uri.parse(
            'https://firegard.cupcoding.com/backend/public/api/admin/devices',
          ),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<DeviceModel> devices = List.generate(
            data['pagination']['items'].length,
            (index) => DeviceModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(DeviceSuccess(devices: devices));
        } else {
          emit(DeviceError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(DeviceError(errorMessage: error.toString()));
      }
    });
    on<CreateNewDevice>((event, emit) async {
      emit(DeviceActionLoading());
      try {
        final response = await Dio().post(
            'https://firegard.cupcoding.com/backend/public/api/admin/devices',
            data: event.createDeviceModel.toMap(),
            options: Options(
              headers: {
                'Authorization':
                    'Bearer ${sharedPreferences.getString('token')}'
              },
            ));
        if (response.statusCode == 201) {
          emit(
            DeviceActionSuccess(actionMessage: 'Device Added Successfuly'),
          );
        } else {
          emit(
            DeviceActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        emit(
          DeviceActionError(
            errorMessage: 'Error create device',
          ),
        );
      }
    });
    on<UpdateDevice>((event, emit) async {
      emit(DeviceActionLoading());
      try {
        final response = await Dio().put(
            'https://firegard.cupcoding.com/backend/public/api/admin/devices/${event.updateDeviceId}',
            data: event.updateDeviceModel.toMap(),
            options: Options(
              headers: {
                'Authorization':
                    'Bearer ${sharedPreferences.getString('token')}'
              },
            ));
        if (response.statusCode == 200) {
          emit(
            DeviceActionSuccess(actionMessage: 'Device Updated Successfuly'),
          );
        } else {
          emit(
            DeviceActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        emit(
          DeviceActionError(
            errorMessage: 'Error update device',
          ),
        );
      }
    });
    on<DeleteDevice>((event, emit) async {
      emit(DeviceActionLoading());
      try {
        final response = await Dio().delete(
            'https://firegard.cupcoding.com/backend/public/api/admin/devices/${event.deleteDeviceId}',
            options: Options(
              headers: {
                'Authorization':
                    'Bearer ${sharedPreferences.getString('token')}'
              },
            ));
        if (response.statusCode == 200) {
          emit(
            DeviceActionSuccess(actionMessage: 'Device Deleted Successfuly'),
          );
        } else {
          emit(
            DeviceActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        emit(
          DeviceActionError(
            errorMessage: 'Error delete device',
          ),
        );
      }
    });
  }
}
