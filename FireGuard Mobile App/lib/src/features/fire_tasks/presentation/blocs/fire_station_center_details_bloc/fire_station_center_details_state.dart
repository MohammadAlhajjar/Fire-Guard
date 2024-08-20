part of 'fire_station_center_details_and_fire_nodes_bloc.dart';

@immutable
sealed class FireStationCenterDetailsState {}

final class FireStationCenterDetailsInitial
    extends FireStationCenterDetailsState {}

final class FireStationCenterLoading extends FireStationCenterDetailsState {}

final class FireStationCenterSuccess extends FireStationCenterDetailsState {
  final List<FireStationCenterModel> fireStationCentersDetails;
  final List<FireNodeModel> fireNodes;

  FireStationCenterSuccess(
      {required this.fireStationCentersDetails, required this.fireNodes});
}

final class FireStationCenterDetailsFailure
    extends FireStationCenterDetailsState {
  final String errorMessage;

  FireStationCenterDetailsFailure({required this.errorMessage});
}
