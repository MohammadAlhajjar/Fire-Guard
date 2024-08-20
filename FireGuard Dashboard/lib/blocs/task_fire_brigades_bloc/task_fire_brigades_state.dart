part of 'task_fire_brigades_bloc.dart';

@immutable
sealed class TaskFireBrigadesState {}

final class TaskFireBrigadesInitial extends TaskFireBrigadesState {}

class GetTaskFireBrigadesLoading extends TaskFireBrigadesState {}

class GetTaskFireBrigadesSuccess extends TaskFireBrigadesState {
  final List<TaskFireBrigadeModel> tasks;

  GetTaskFireBrigadesSuccess({required this.tasks});
}

class GetTaskFireBrigadesError extends TaskFireBrigadesState {
  final String errorMessage;

  GetTaskFireBrigadesError({required this.errorMessage});
}

final class TaskFireActionSuccess extends TaskFireBrigadesState {
  final String actionMessage;
  TaskFireActionSuccess({required this.actionMessage});
}

final class TaskFireActionLoading extends TaskFireBrigadesState {}

final class TaskFireActionError extends TaskFireBrigadesState {
  final String errorMessage;

  TaskFireActionError({required this.errorMessage});
}
