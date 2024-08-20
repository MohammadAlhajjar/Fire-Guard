part of 'update_fire_status_bloc.dart';

@immutable
sealed class UpdateFireStatusState {}

final class UpdateFireStatusInitial extends UpdateFireStatusState {}

final class UpdateFireStatusSuccess extends UpdateFireStatusState {
  final FireLocationOrHistoryModel fireModel;

  UpdateFireStatusSuccess({required this.fireModel});
}

final class UpdateFireStatusLoading extends UpdateFireStatusState {}

final class UpdateFireStatusFailure extends UpdateFireStatusState {
  final String errorMessage;

  UpdateFireStatusFailure({required this.errorMessage});
}
