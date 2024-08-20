part of 'car_bloc.dart';

@immutable
sealed class CarState {}

final class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarSuccess extends CarState {
  final List<CarModel> cars;

  CarSuccess({required this.cars});
}

class CarError extends CarState {
  final String errorMessage;

  CarError({required this.errorMessage});
}

class CarActionSuccess extends CarState {
  final String actionMessage;

  CarActionSuccess({required this.actionMessage});
}

class CarActionLoading extends CarState {}

class CarActionError extends CarState {}
