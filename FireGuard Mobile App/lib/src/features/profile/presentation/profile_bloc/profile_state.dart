part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final FireBrigadePofileModel fireBrigadePofileModel;

  ProfileSuccess({required this.fireBrigadePofileModel});
}

final class ProfileLoading extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure({required this.errorMessage});
}
