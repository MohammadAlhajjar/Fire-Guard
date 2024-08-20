part of 'forest_bloc.dart';

@immutable
sealed class ForestState {}

final class ForestInitial extends ForestState {}

class ForestLoading extends ForestState {}

class ForestSuccess extends ForestState {
  final List<ForestModel> forests;

  ForestSuccess({required this.forests});
}

class ForestError extends ForestState {
  final String errorMessage;

  ForestError({required this.errorMessage});
}

class ForestActionSuccess extends ForestState {
  final String actionMessage;

  ForestActionSuccess({required this.actionMessage});
}

class ForestActionLoading extends ForestState {}

class ForestActionError extends ForestState {
  final String errorMessage;

  ForestActionError({required this.errorMessage});
}
