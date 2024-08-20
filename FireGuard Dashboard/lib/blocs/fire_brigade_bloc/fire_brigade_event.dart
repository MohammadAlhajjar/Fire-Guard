part of 'fire_brigade_bloc.dart';

@immutable
sealed class FireBrigadeEvent {}

class FetchFireBrigades extends FireBrigadeEvent {}

class CreateFireBrigade extends FireBrigadeEvent {
  final CreateOrUpdateFireBrigadeModel createFireBrigadeModel;

  CreateFireBrigade({required this.createFireBrigadeModel});
}

class UpdateFireBrigade extends FireBrigadeEvent {
  final CreateOrUpdateFireBrigadeModel updateFireBrigadeModel;
  final String updateFireBrigadeId;

  UpdateFireBrigade(this.updateFireBrigadeId,
      {required this.updateFireBrigadeModel});
}

final class DeleteFireBrigade extends FireBrigadeEvent {
  final String deleteFireBrigadeId;

  DeleteFireBrigade({required this.deleteFireBrigadeId});
}
