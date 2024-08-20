part of 'center_bloc.dart';

@immutable
sealed class CenterEvent {}

class FetchCenters extends CenterEvent {}

class CreateCenter extends CenterEvent {
  final CreateOrUpdateCenterModel createCenterModel;

  CreateCenter({required this.createCenterModel});
}

class UpdateCenter extends CenterEvent {
  final String updateCenterId;
  final CreateOrUpdateCenterModel updateCenterModel;

  UpdateCenter({required this.updateCenterId, required this.updateCenterModel});
}

final class DeleteCenter extends CenterEvent {
  final String deleteCenterId;

  DeleteCenter({required this.deleteCenterId});
}
