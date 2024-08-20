// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_location_model.dart';
import 'package:meta/meta.dart';

import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_location_repository.dart';

import '../../../../../../core/helper/bloc_helper.dart';

part 'fire_location_event.dart';
part 'fire_location_state.dart';

class FireLocationBloc extends Bloc<FireEvent, FireLocationState> {
  FireLocationRepo fireLocationRepo;
  FireLocationBloc({
    required this.fireLocationRepo,
  }) : super(FireLocationInitial()) {
    on<GetFireLocation>((event, emit) async {
      emit(FireLocationLoading());
      var failureOrFireLocation =
          await fireLocationRepo.getFireLocationById(taskFireId: event.fireId);

      failureOrFireLocation.fold((failure) {
        emit(
          FireLocationFailure(
            errorMessage: FailureHelper.mapFailureToMessage(
              failure,
            ),
          ),
        );
      }, (fireLocation) {
        emit(
          FireLocationSuccess(
            fireLocationModel: fireLocation,
          ),
        );
      });
    });
  }
}
