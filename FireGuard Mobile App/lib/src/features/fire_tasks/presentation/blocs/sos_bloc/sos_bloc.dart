import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/resource/constants_manager.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/sos_request_model.dart';
import 'package:meta/meta.dart';

import '../../../../../../main.dart';
import '../../../../profile/data/model/fire_brigade_profile_model.dart';

part 'sos_event.dart';
part 'sos_state.dart';

class SosBloc extends Bloc<SosEvent, SosState> {
  SosBloc() : super(SosInitial()) {
    on<SendSosRequestEvent>((event, emit) async {
      emit(SosLoading());
      try {
        String? centerId = await getCenterId();
        Map<String, dynamic> sosMap =
            event.sosRequestMdoel.copyWith(center: centerId).toMap();
        print(sosMap);
        final response = await Dio().post(
          'https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigade/emergency-requests',
          data: sosMap,
        );
        if (response.statusCode == 200) {
          emit(SosSuccess());
        } else {
          emit(
            SosFailure(
              errorMessage: 'Sever probelm, Please try again later....',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          SosFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
  Future<String?> getCenterId() async {
    final response = await Dio().get(
      'https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigades/profile',
      options: Options(
        headers: {
          'Authorization':
              'Bearer ${sharedPreferences.getString(ConstantsManager.tokenKey)}',
        },
      ),
    );
    if (response.statusCode == 200) {
      FireBrigadePofileModel fireBrigadePofileModel =
          FireBrigadePofileModel.fromMap(response.data['data']['fireBrigades']);
      print('=======================centerID=================');
      print(fireBrigadePofileModel);
      return fireBrigadePofileModel.center!.id!.toString();
    } else {
      return null;
    }
  }
}
