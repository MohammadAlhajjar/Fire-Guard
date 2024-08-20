part of 'update_fire_status_bloc.dart';

@immutable
sealed class UpdateFireStatusEvent {}

final class UpdateFireStatus extends UpdateFireStatusEvent {
  final UpdateFireStatusModel fireStatusModel;
  final String taskFireId;

  UpdateFireStatus(this.taskFireId, {required this.fireStatusModel});
}

final class InitialStateRequest extends UpdateFireStatusEvent {}
