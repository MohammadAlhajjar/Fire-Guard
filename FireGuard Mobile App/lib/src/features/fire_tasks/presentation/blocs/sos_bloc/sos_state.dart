part of 'sos_bloc.dart';

@immutable
sealed class SosState {}

final class SosInitial extends SosState {}

final class SosSuccess extends SosState {}

final class SosLoading extends SosState {}

final class SosFailure extends SosState {
  final String errorMessage;

  SosFailure({required this.errorMessage});
}
