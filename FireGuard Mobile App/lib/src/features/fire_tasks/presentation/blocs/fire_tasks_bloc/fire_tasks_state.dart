part of 'fire_tasks_bloc.dart';

@immutable
sealed class FireTasksState {}

final class FireTasksInitial extends FireTasksState {}

final class FireTasksSuccess extends FireTasksState {
  final List<FireTask> fireTasks;

  FireTasksSuccess({required this.fireTasks});
}

final class FireTasksLoading extends FireTasksState {}

final class FireTasksFailure extends FireTasksState {
  final String errorMessage;

  FireTasksFailure({required this.errorMessage});
}
