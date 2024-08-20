part of 'device_values_bloc.dart';

@immutable
sealed class DeviceValuesEvent {}

class FetchDeviceValues extends DeviceValuesEvent {}
