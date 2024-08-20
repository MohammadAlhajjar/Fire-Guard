import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import '../../models/create_forest_model.dart';
import '../../models/forest_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'forest_event.dart';
part 'forest_state.dart';

class ForestBloc extends Bloc<ForestEvent, ForestState> {
  ForestBloc() : super(ForestInitial()) {
    on<FetchForests>((event, emit) async {
      emit(ForestLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/forests'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<ForestModel> forests = List.generate(
            data['pagination']['items'].length,
            (index) => ForestModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(ForestSuccess(forests: forests));
        } else {
          emit(ForestError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(ForestError(errorMessage: error.toString()));
      }
    });
    on<CreateForest>((event, emit) async {
      emit(ForestLoading());
      try {
        final response = await Dio().post(
          'https://firegard.cupcoding.com/backend/public/api/admin/forests',
          data: event.createForestModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );

        if (response.statusCode == 201) {
          emit(
            ForestActionSuccess(
              actionMessage: 'Forest Added Successfuly',
            ),
          );
        } else {
          emit(ForestError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(ForestError(errorMessage: error.toString()));
      }
    });
    on<UpdateForest>((event, emit) async {
      emit(ForestLoading());
      try {
        final response = await Dio().put(
          'https://firegard.cupcoding.com/backend/public/api/admin/forests/${event.updateForestId}',
          data: event.updateForestModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(
            ForestActionSuccess(
              actionMessage: 'Forest Updated Successfuly',
            ),
          );
        } else {
          emit(ForestError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(ForestError(errorMessage: error.toString()));
      }
    });
    on<DeleteForest>((event, emit) async {
      emit(ForestLoading());
      try {
        final response = await Dio().delete(
          'https://firegard.cupcoding.com/backend/public/api/admin/forests/${event.deleteForestId}',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(
            ForestActionSuccess(
              actionMessage: 'Forest Deleted Successfuly',
            ),
          );
        } else {
          emit(ForestError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(ForestError(errorMessage: error.toString()));
      }
    });
  }
}
