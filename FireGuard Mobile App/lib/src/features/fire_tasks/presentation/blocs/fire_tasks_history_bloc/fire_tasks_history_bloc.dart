import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/fire_location_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_location_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_task_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/bloc_helper.dart';

part 'fire_tasks_history_event.dart';
part 'fire_tasks_history_state.dart';

class FireTasksHistoryBloc
    extends Bloc<FireTasksHistoryEvent, FireTasksHistoryState> {
  final FireTaskRepo fireTaskRepo;
  FireTasksHistoryBloc({required this.fireTaskRepo})
      : super(FireTasksHistoryInitial()) {
    on<GetAllFireTasksHistory>((event, emit) async {
      emit(FireTasksHistoryLoading());
      var failureOrFireTasksHistory =
          await fireTaskRepo.getAllFireTasksForHistory();

      failureOrFireTasksHistory.fold((failure) {
        emit(
          FireTasksHistoryFailure(
            errorMessage: FailureHelper.mapFailureToMessage(
              failure,
            ),
          ),
        );
      }, (fireTasksHistory) {
        List<FireLocationOrHistoryModel> historyTaskFires = [];
        for (var i = 0; i < fireTasksHistory.length; i++) {
          if (fireTasksHistory[i].status == FireStatus.COMPLETED.name ||
              fireTasksHistory[i].status == FireStatus.CANCELED.name) {
            historyTaskFires.add(fireTasksHistory[i]);
          }
        }
        emit(
          FireTasksHistorySuccess(
            fireTasksHistory: historyTaskFires,
          ),
        );
      });
    });
  }
}
