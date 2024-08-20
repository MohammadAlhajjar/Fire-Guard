import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import '../../models/center_model.dart';
import '../../models/create_center_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'center_event.dart';
part 'center_state.dart';

class CenterBloc extends Bloc<CenterEvent, CenterState> {
  CenterBloc() : super(CenterInitial()) {
    on<CenterEvent>((event, emit) async {
      emit(CenterLoading());
      try {
        final response = await http.get(
            Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/centers',
            ),
            headers: {
              'Authorization':
                  'Bearer ${sharedPreferences.getString('token')}', // Replace with your token
            });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          final List<CenterModel> centers = List.generate(
            data['pagination']['items'].length,
            (index) => CenterModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(
            CenterSuccess(centers: centers),
          );
        } else {
          emit(
            CenterError(
              errorMessage: 'Failed to load centers',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(CenterError(errorMessage: e.toString()));
      }
    });
    on<CreateCenter>((event, emit) async {
      emit(CenterActionLoading());
      try {
        final response = await Dio().post(
          'https://firegard.cupcoding.com/backend/public/api/admin/centers',
          data: event.createCenterModel.toMap(),
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${sharedPreferences.getString('token')}', // Replace with your token
            },
          ),
        );

        if (response.statusCode == 201) {
          emit(
            CenterActionSuccess(actionMessage: 'Center Added Successfuly'),
          );
        } else {
          emit(
            CenterError(
              errorMessage: 'Failed to Add center',
            ),
          );
        }
      } catch (e) {
        emit(CenterError(errorMessage: e.toString()));
      }
    });
    on<UpdateCenter>((event, emit) async {
      emit(CenterActionLoading());
      try {
        final response = await Dio().put(
          'https://firegard.cupcoding.com/backend/public/api/admin/centers/${event.updateCenterId}',
          data: event.updateCenterModel.toMap(),
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${sharedPreferences.getString('token')}', // Replace with your token
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(
            CenterActionSuccess(actionMessage: 'Center Updated Successfuly'),
          );
        } else {
          emit(
            CenterError(
              errorMessage: 'Failed to Update Center',
            ),
          );
        }
      } catch (e) {
        emit(CenterError(errorMessage: e.toString()));
      }
    });
    on<DeleteCenter>((event, emit) async {
      emit(CenterActionLoading());
      try {
        final response = await Dio().delete(
          'https://firegard.cupcoding.com/backend/public/api/admin/centers/${event.deleteCenterId}',
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${sharedPreferences.getString('token')}', // Replace with your token
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(
            CenterActionSuccess(actionMessage: 'Center Deleted Successfuly'),
          );
        } else {
          emit(
            CenterError(
              errorMessage: 'Failed to Delete center',
            ),
          );
        }
      } catch (e) {
        emit(CenterError(errorMessage: e.toString()));
      }
    });
  }
}
