part of 'sos_bloc.dart';

@immutable
sealed class SosEvent {}

final class SendSosRequestEvent extends SosEvent {
  final SosRequestMdoel sosRequestMdoel;

  SendSosRequestEvent({required this.sosRequestMdoel});
}
