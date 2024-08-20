part of 'fire_station_center_details_and_fire_nodes_bloc.dart';

@immutable
sealed class FireStationCenterDetailsEvent {}

final class GetFireStationCenterDetailsAndFireNodes
    extends FireStationCenterDetailsEvent {}
