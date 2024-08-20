part of 'car_bloc.dart';

@immutable
sealed class CarEvent {}

class FetchCars extends CarEvent {}

class CreateCar extends CarEvent {
  final CreateOrUpdateCarModel createCarModel;

  CreateCar({required this.createCarModel});
}

class UpdateCar extends CarEvent {
  final CreateOrUpdateCarModel updateCarModel;
  final String updateCarId;

  UpdateCar({required this.updateCarId, required this.updateCarModel});
}

class DeleteCar extends CarEvent {
  final String deleteCarId;

  DeleteCar({required this.deleteCarId});
}
