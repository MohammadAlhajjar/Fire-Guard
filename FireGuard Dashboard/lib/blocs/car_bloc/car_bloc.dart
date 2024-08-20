import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import '../../models/car_model.dart';
import '../../models/create_car_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(CarInitial()) {
    on<FetchCars>((event, emit) async {
      emit(CarLoading());
      try {
        final response = await http.get(
            Uri.parse(
                'https://firegard.cupcoding.com/backend/public/api/admin/cars'),
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<CarModel> cars = List.generate(
            data['pagination']['items'].length,
            (index) => CarModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(CarSuccess(cars: cars));
        } else {
          emit(
            CarError(
              errorMessage: 'Failed to load cars',
            ),
          );
        }
      } catch (e) {
        emit(
          CarError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<CreateCar>((event, emit) async {
      emit(CarActionLoading());
      try {
        final response = await Dio().post(
          'https://firegard.cupcoding.com/backend/public/api/admin/cars',
          data: event.createCarModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            },
          ),
        );

        if (response.statusCode == 201) {
          emit(
            CarActionSuccess(
              actionMessage: 'Car Added Successfuly',
            ),
          );
        } else {
          emit(
            CarError(
              errorMessage: 'Failed to add car',
            ),
          );
        }
      } catch (e) {
        emit(
          CarError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<UpdateCar>((event, emit) async {
      emit(CarActionLoading());
      try {
        final response = await Dio().put(
          'https://firegard.cupcoding.com/backend/public/api/admin/cars/${event.updateCarId}',
          data: event.updateCarModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(
            CarActionSuccess(
              actionMessage: 'Car Update Successfuly',
            ),
          );
        } else {
          emit(
            CarError(
              errorMessage: 'Failed to update car',
            ),
          );
        }
      } catch (e) {
        emit(
          CarError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<DeleteCar>((event, emit) async {
      emit(CarActionLoading());
      try {
        final response = await Dio().delete(
          'https://firegard.cupcoding.com/backend/public/api/admin/cars/${event.deleteCarId}',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(
            CarActionSuccess(
              actionMessage: 'Car Deleted Successfuly',
            ),
          );
        } else {
          emit(
            CarError(
              errorMessage: 'Failed to delete car',
            ),
          );
        }
      } catch (e) {
        emit(
          CarError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
