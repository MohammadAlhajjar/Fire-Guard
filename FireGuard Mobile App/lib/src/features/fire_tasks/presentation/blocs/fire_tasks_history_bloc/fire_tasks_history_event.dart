part of 'fire_tasks_history_bloc.dart';

@immutable
sealed class FireTasksHistoryEvent {}

final class GetAllFireTasksHistory extends FireTasksHistoryEvent {}
