part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInLoadingState extends AuthState {}

class SignInFailureState extends AuthState {
  final String errorMessage;

  SignInFailureState({required this.errorMessage});
}
