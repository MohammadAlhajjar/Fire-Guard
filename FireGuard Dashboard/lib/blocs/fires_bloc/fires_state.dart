part of 'fires_bloc.dart';

sealed class FiresState {
  const FiresState();
}

final class FiresInitial extends FiresState {}

class FiresLoading extends FiresState {}

class FiresSuccess extends FiresState {
  final List<FireModel> fires;

  FiresSuccess({required this.fires});
}

class FiresError extends FiresState {
  final String errorMessage;

  FiresError({required this.errorMessage});
}
