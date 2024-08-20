part of 'fires_bloc.dart';

sealed class FiresEvent {
  const FiresEvent();
}

final class FetchFiresEvent extends FiresEvent {}
