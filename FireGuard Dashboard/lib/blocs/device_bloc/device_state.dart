part of 'device_bloc.dart';

@immutable
sealed class DeviceState {}

final class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceSuccess extends DeviceState {
  final List<DeviceModel> devices;

  DeviceSuccess({required this.devices});
}

class DeviceError extends DeviceState {
  final String errorMessage;

  DeviceError({required this.errorMessage});
}

class DeviceActionSuccess extends DeviceState {
  final String actionMessage;

  DeviceActionSuccess({required this.actionMessage});
}

class DeviceActionLoading extends DeviceState {}

class DeviceActionError extends DeviceState {
  final String errorMessage;

  DeviceActionError({required this.errorMessage});
}
