import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import '../../models/create_task_fire_model.dart';
import '../../models/task_fire_brigade_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'task_fire_brigades_event.dart';
part 'task_fire_brigades_state.dart';

class TaskFireBrigadesBloc
    extends Bloc<TaskFireBrigadesEvent, TaskFireBrigadesState> {
  TaskFireBrigadesBloc() : super(TaskFireBrigadesInitial()) {
    on<FetchTaskFireBrigades>((event, emit) async {
      emit(GetTaskFireBrigadesLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/task-fire-brigades'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<TaskFireBrigadeModel> tasks = List.generate(
            data['pagination']['items'].length,
            (index) => TaskFireBrigadeModel.fromMap(
                data['pagination']['items'][index]),
          );
          emit(
            GetTaskFireBrigadesSuccess(
              tasks: tasks,
            ),
          );
        } else {
          emit(
            GetTaskFireBrigadesError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          GetTaskFireBrigadesError(
            errorMessage: 'Error fetching data',
          ),
        );
      }
    });
    on<CreateNewTaskFire>((event, emit) async {
      emit(TaskFireActionLoading());
      try {
        final response = await Dio().post(
          'https://firegard.cupcoding.com/backend/public/api/admin/task-fire-brigades',
          data: event.createTaskFireModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );

        if (response.statusCode == 201) {
          emit(
            TaskFireActionSuccess(
              actionMessage: 'Task Added Successfuly',
            ),
          );
        } else {
          emit(
            TaskFireActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          TaskFireActionError(
            errorMessage: 'Error create data',
          ),
        );
      }
    });
    on<UpdateTaskFire>((event, emit) async {
      emit(TaskFireActionLoading());
      try {
        final response = await Dio().put(
          'https://firegard.cupcoding.com/backend/public/api/admin/task-fire-brigades/${event.updateTaskFireId}',
          data: event.updateTaskFireModel.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );
        print(response.data);
        if (response.statusCode == 200) {
          emit(
            TaskFireActionSuccess(actionMessage: 'Task Updated Successfuly'),
          );
        } else {
          emit(
            TaskFireActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          TaskFireActionError(
            errorMessage: 'Error Update data',
          ),
        );
      }
    });
    on<DeleteTaskFire>((event, emit) async {
      emit(TaskFireActionLoading());
      try {
        final response = await Dio().delete(
          'https://firegard.cupcoding.com/backend/public/api/admin/task-fire-brigades/${event.taskFireId}',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
            },
          ),
        );
        if (response.statusCode == 200) {
          emit(
            TaskFireActionSuccess(actionMessage: 'Task Deleted Successfuly'),
          );
        } else {
          emit(
            TaskFireActionError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        print(e);
        emit(
          TaskFireActionError(
            errorMessage: 'Error Delete data',
          ),
        );
      }
    });
  }
}
