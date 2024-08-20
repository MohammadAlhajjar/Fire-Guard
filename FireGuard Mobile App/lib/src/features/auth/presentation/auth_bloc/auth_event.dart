part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInEvent extends AuthEvent {
  final SignInModel signInModel;

  SignInEvent({required this.signInModel});
}

