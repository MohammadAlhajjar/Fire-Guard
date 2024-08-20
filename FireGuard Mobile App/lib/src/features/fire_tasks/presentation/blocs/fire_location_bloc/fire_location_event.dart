part of 'fire_location_bloc.dart';

@immutable
sealed class FireEvent {}

final class GetFireLocation extends FireEvent {
  final int fireId;

  GetFireLocation({required this.fireId});
}


