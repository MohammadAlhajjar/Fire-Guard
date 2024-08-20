part of 'center_bloc.dart';

@immutable
sealed class CenterState {}

final class CenterInitial extends CenterState {}

class CenterLoading extends CenterState {}

class CenterSuccess extends CenterState {
  final List<CenterModel> centers;

  CenterSuccess({required this.centers});
}

class CenterError extends CenterState {
  final String errorMessage;

  CenterError({required this.errorMessage});
}

final class CenterActionSuccess extends CenterState {
  final String actionMessage;

  CenterActionSuccess({required this.actionMessage});
}

final class CenterActionLoading extends CenterState {}

final class CenterActionError extends CenterState {
  final String errorMessage;

  CenterActionError({required this.errorMessage});
}
