import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import '../../models/create_fire_brigade_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../models/fire_brigade_model.dart';

part 'fire_brigade_event.dart';
part 'fire_brigade_state.dart';

class FireBrigadeBloc extends Bloc<FireBrigadeEvent, FireBrigadeState> {
  FireBrigadeBloc() : super(FireBrigadeInitial()) {
    on<FetchFireBrigades>((event, emit) async {
      emit(FireBrigadeLoading());
      try {
        final response = await http.get(
            Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/fire-brigades',
            ),
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<FireBrigadeModel> fireBrigades = List.generate(
            data['pagination']['items'].length,
            (index) => FireBrigadeModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(FireBrigadeSuccess(fireBrigades: fireBrigades));
        } else {
          emit(
            FireBrigadeError(
              errorMessage: 'Failed to load fire brigades',
            ),
          );
        }
      } catch (e) {
        emit(
          FireBrigadeError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<CreateFireBrigade>((event, emit) async {
      emit(FireBrigadeActionLoading());
      try {
        final response = await Dio().post(
          'https://firegard.cupcoding.com/backend/public/api/admin/fire-brigades',
          data: event.createFireBrigadeModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );
        print(response.data);
        if (response.statusCode == 201) {
          emit(
            FireBrigadeActionSuccesss(
              actionMessage: 'Fire Brigade Added Successfuly',
            ),
          );
        } else {
          emit(
            FireBrigadeActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          FireBrigadeActionError(
            errorMessage: 'Error create data',
          ),
        );
      }
    });
    on<UpdateFireBrigade>((event, emit) async {

      emit(FireBrigadeActionLoading());
      try {
        final response = await Dio().put(
          'https://firegard.cupcoding.com/backend/public/api/admin/fire-brigades/${event.updateFireBrigadeId}',
          data: event.updateFireBrigadeModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );
        if (response.statusCode == 200) {
          emit(
            FireBrigadeActionSuccesss(
              actionMessage: 'Fire Brigade Updated Successfuly',
            ),
          );
        } else {
          emit(
            FireBrigadeActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          FireBrigadeActionError(
            errorMessage: 'Error Update data',
          ),
        );
      }
    });
    on<DeleteFireBrigade>((event, emit) async {
      emit(FireBrigadeActionLoading());
      try {
        final response = await Dio().delete(
          'https://firegard.cupcoding.com/backend/public/api/admin/fire-brigades/${event.deleteFireBrigadeId}',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );
        if (response.statusCode == 200) {
          emit(
            FireBrigadeActionSuccesss(
              actionMessage: 'Fire Brigade Deleted Successfuly',
            ),
          );
        } else {
          emit(
            FireBrigadeActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          FireBrigadeActionError(
            errorMessage: 'Error Delete data',
          ),
        );
      }
    });
  }
}
