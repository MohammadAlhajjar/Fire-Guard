part of 'device_bloc.dart';

@immutable
sealed class DeviceEvent {}

class FetchDevices extends DeviceEvent {}

class CreateNewDevice extends DeviceEvent {
  final CreateOrUpdateDeviceModel createDeviceModel;

  CreateNewDevice({required this.createDeviceModel});
}

class UpdateDevice extends DeviceEvent {
  final CreateOrUpdateDeviceModel updateDeviceModel;
  final String updateDeviceId;

  UpdateDevice({required this.updateDeviceModel, required this.updateDeviceId});
}

class DeleteDevice extends DeviceEvent {
  final String deleteDeviceId;

  DeleteDevice({required this.deleteDeviceId});
}
