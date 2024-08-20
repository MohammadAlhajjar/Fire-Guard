import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/headers_helper.dart';
import '../../../data/models/fire_location_model.dart';
import '../../../data/models/update_fire_status_model.dart';

part 'update_fire_status_event.dart';
part 'update_fire_status_state.dart';

class UpdateFireStatusBloc
    extends Bloc<UpdateFireStatusEvent, UpdateFireStatusState> {
  UpdateFireStatusBloc() : super(UpdateFireStatusInitial()) {
    on<InitialStateRequest>((event, emit) {
      // sharedPreferences.setString('fireStatus', '');
      emit(UpdateFireStatusInitial());
    });
    on<UpdateFireStatus>(
      (event, emit) async {
        emit(UpdateFireStatusLoading());
        try {
          print(
              '======================================test A ======================');
          var response =
              await _updateFireStatus(event.fireStatusModel, event.taskFireId);
                        print(
              '======================================test B======================');
          print(response.data['data']);
          if (response.statusCode == 200) {
            var fireModelAfterUpdate = FireLocationOrHistoryModel.fromMap(
              response.data['data'],
            );
            print("==========hello====================================");
            print(response.data['data']);
            // sharedPreferences.setString(
            //     'fireStatus', fireModelAfterUpdate.status!.value!);
            emit(UpdateFireStatusSuccess(fireModel: fireModelAfterUpdate));
          } else {
            emit(UpdateFireStatusFailure(
                errorMessage: 'Server problem, Please try again later'));
          }
        } catch (e) {
          print("============<<<<<$e>>>>>>>>>>>>>>>>=================");
          emit(
            UpdateFireStatusFailure(
                errorMessage:
                    'Server problem, Please try again later, Exception is: $e'),
          );
        }
      },
    );
  }
  Future<Response> _updateFireStatus(
      UpdateFireStatusModel fireStatusModel, String taskFireId) async {
    return await Dio().put(
      'https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigade/task-fire-brigades/$taskFireId',
      data: fireStatusModel.toMap(),
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );
  }
}
