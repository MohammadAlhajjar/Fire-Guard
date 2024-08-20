part of 'device_values_bloc.dart';

@immutable
sealed class DeviceValuesState {}

final class DeviceValuesInitial extends DeviceValuesState {}

class DeviceValuesLoading extends DeviceValuesState {}

class DeviceValuesSuccess extends DeviceValuesState {
  final List<DeviceValueModel> deviceValues;

  DeviceValuesSuccess({required this.deviceValues});
}

class DeviceValuesError extends DeviceValuesState {
  final String errorMessage;

  DeviceValuesError({required this.errorMessage});
}
