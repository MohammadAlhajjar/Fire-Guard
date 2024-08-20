part of 'fire_tasks_history_bloc.dart';

@immutable
sealed class FireTasksHistoryState {}

final class FireTasksHistoryInitial extends FireTasksHistoryState {}

final class FireTasksHistorySuccess extends FireTasksHistoryState {
  final List<FireLocationOrHistoryModel> fireTasksHistory;

  FireTasksHistorySuccess({required this.fireTasksHistory});
}

final class FireTasksHistoryLoading extends FireTasksHistoryState {}

final class FireTasksHistoryFailure extends FireTasksHistoryState {
  final String errorMessage;

  FireTasksHistoryFailure({required this.errorMessage});
}
