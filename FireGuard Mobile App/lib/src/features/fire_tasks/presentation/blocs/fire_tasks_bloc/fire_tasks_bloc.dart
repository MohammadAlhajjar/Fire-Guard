// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/helper/bloc_helper.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/sos_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_task_repository.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/helper/headers_helper.dart';
import '../../../data/models/fire_task_model.dart';

part 'fire_tasks_event.dart';
part 'fire_tasks_state.dart';

class FireTasksBloc extends Bloc<FireTasksEvent, FireTasksState> {
  final FireTaskRepo fireTaskRepo;
  FireTasksBloc({required this.fireTaskRepo}) : super(FireTasksInitial()) {
    on<GetAllFireTasks>((event, emit) async {

      emit(FireTasksLoading());
      var failureOrFireTasks = await fireTaskRepo.getAllFireTasks();

      failureOrFireTasks.fold((failure) {
        emit(
          FireTasksFailure(
            errorMessage: FailureHelper.mapFailureToMessage(
              failure,
            ),
          ),
        );
      }, (fireTasks) {
        emit(
          FireTasksSuccess(
            fireTasks: fireTasks,
          ),
        );
      });
    });
  }
}
