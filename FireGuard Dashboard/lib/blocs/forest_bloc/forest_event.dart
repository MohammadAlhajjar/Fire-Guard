part of 'forest_bloc.dart';

@immutable
sealed class ForestEvent {}

class FetchForests extends ForestEvent {}

class CreateForest extends ForestEvent {
  final CreateOrUpdateForestModel createForestModel;

  CreateForest({required this.createForestModel});
}

class UpdateForest extends ForestEvent {
  final CreateOrUpdateForestModel updateForestModel;
  final String updateForestId;

  UpdateForest({required this.updateForestId, required this.updateForestModel});
}

final class DeleteForest extends ForestEvent {
  final String deleteForestId;

  DeleteForest({required this.deleteForestId});
}
