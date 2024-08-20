part of 'task_fire_brigades_bloc.dart';

@immutable
sealed class TaskFireBrigadesEvent {}

class FetchTaskFireBrigades extends TaskFireBrigadesEvent {}

final class CreateNewTaskFire extends TaskFireBrigadesEvent {
  final CreateOrUpdateTaskFireModel createTaskFireModel;

  CreateNewTaskFire({required this.createTaskFireModel});
}

final class UpdateTaskFire extends TaskFireBrigadesEvent {
  final CreateOrUpdateTaskFireModel updateTaskFireModel;
  final String updateTaskFireId;

  UpdateTaskFire(this.updateTaskFireId, {required this.updateTaskFireModel});
}

final class DeleteTaskFire extends TaskFireBrigadesEvent {
  final String taskFireId;

  DeleteTaskFire({required this.taskFireId});
}
