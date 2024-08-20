// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'device_model.dart';



class DeviceValueModel {
  final DeviceModel? device;
  final int? id;
  final String? status;
  final num? valueHeat;
  final num? valueMoisture;
  final num? valueGas;
  final String? date;
  final String? createdAt;
  final String? updatedAt;
  DeviceValueModel({
    this.device,
    this.id,
    this.status,
    this.valueHeat,
    this.valueMoisture,
    this.valueGas,
    this.date,
    this.createdAt,
    this.updatedAt,
  });



  DeviceValueModel copyWith({
    DeviceModel? device,
    int? id,
    String? status,
    num? valueHeat,
    num? valueMoisture,
    num? valueGas,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) {
    return DeviceValueModel(
      device: device ?? this.device,
      id: id ?? this.id,
      status: status ?? this.status,
      valueHeat: valueHeat ?? this.valueHeat,
      valueMoisture: valueMoisture ?? this.valueMoisture,
      valueGas: valueGas ?? this.valueGas,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'device': device?.toMap(),
      'id': id,
      'status': status,
      'valueHeat': valueHeat,
      'valueMoisture': valueMoisture,
      'valueGas': valueGas,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory DeviceValueModel.fromMap(Map<String, dynamic> map) {
    return DeviceValueModel(
      device: map['device'] != null ? DeviceModel.fromMap(map['device'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      valueHeat: map['valueHeat'] != null ? map['valueHeat'] as num : null,
      valueMoisture: map['valueMoisture'] != null ? map['valueMoisture'] as num : null,
      valueGas: map['valueGas'] != null ? map['valueGas'] as num : null,
      date: map['date'] != null ? map['date'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceValueModel.fromJson(String source) => DeviceValueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceValueModel(device: $device, id: $id, status: $status, valueHeat: $valueHeat, valueMoisture: $valueMoisture, valueGas: $valueGas, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant DeviceValueModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.device == device &&
      other.id == id &&
      other.status == status &&
      other.valueHeat == valueHeat &&
      other.valueMoisture == valueMoisture &&
      other.valueGas == valueGas &&
      other.date == date &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return device.hashCode ^
      id.hashCode ^
      status.hashCode ^
      valueHeat.hashCode ^
      valueMoisture.hashCode ^
      valueGas.hashCode ^
      date.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
