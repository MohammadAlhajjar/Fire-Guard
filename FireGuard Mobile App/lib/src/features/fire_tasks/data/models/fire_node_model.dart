// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_location_model.dart';

class FireNodeModel {
  final ForestModel? forest;
  final DeviceValueModel? deviceValues;
  final int? id;
  final String? name;
  final String? description;
  final String? nameAddress;
  final String? longitude;
  final String? latitude;
  final String? createdAt;
  final String? updatedAt;
  FireNodeModel({
    this.forest,
    this.deviceValues,
    this.id,
    this.name,
    this.description,
    this.nameAddress,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
  });

  FireNodeModel copyWith({
    ForestModel? forest,
    DeviceValueModel? deviceValues,
    int? id,
    String? name,
    String? description,
    String? nameAddress,
    String? longitude,
    String? latitude,
    String? createdAt,
    String? updatedAt,
  }) {
    return FireNodeModel(
      forest: forest ?? this.forest,
      deviceValues: deviceValues ?? this.deviceValues,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      nameAddress: nameAddress ?? this.nameAddress,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'forest': forest?.toMap(),
      'deviceValues': deviceValues?.toMap(),
      'id': id,
      'name': name,
      'description': description,
      'nameAddress': nameAddress,
      'longitude': longitude,
      'latitude': latitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FireNodeModel.fromMap(Map<String, dynamic> map) {
    return FireNodeModel(
      forest: map['forest'] != null ? ForestModel.fromMap(map['forest'] as Map<String,dynamic>) : null,
      deviceValues: map['deviceValues'] != null ? DeviceValueModel.fromMap(map['deviceValues'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      nameAddress: map['nameAddress'] != null ? map['nameAddress'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireNodeModel.fromJson(String source) => FireNodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireNodeModel(forest: $forest, deviceValues: $deviceValues, id: $id, name: $name, description: $description, nameAddress: $nameAddress, longitude: $longitude, latitude: $latitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FireNodeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.forest == forest &&
      other.deviceValues == deviceValues &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.nameAddress == nameAddress &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return forest.hashCode ^
      deviceValues.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      nameAddress.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

class DeviceValueModel {
  final int? id;
  final String? status;
  final num? valueHeat;
  final num? valueMoisture;
  final num? valueGas;
  final String? date;
  DeviceValueModel({
    this.id,
    this.status,
    this.valueHeat,
    this.valueMoisture,
    this.valueGas,
    this.date,
  });

  DeviceValueModel copyWith({
    int? id,
    String? status,
    num? valueHeat,
    num? valueMoisture,
    num? valueGas,
    String? date,
  }) {
    return DeviceValueModel(
      id: id ?? this.id,
      status: status ?? this.status,
      valueHeat: valueHeat ?? this.valueHeat,
      valueMoisture: valueMoisture ?? this.valueMoisture,
      valueGas: valueGas ?? this.valueGas,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'valueHeat': valueHeat,
      'valueMoisture': valueMoisture,
      'valueGas': valueGas,
      'date': date,
    };
  }

  factory DeviceValueModel.fromMap(Map<String, dynamic> map) {
    return DeviceValueModel(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      valueHeat: map['valueHeat'] != null ? map['valueHeat'] as num : null,
      valueMoisture: map['valueMoisture'] != null ? map['valueMoisture'] as num : null,
      valueGas: map['valueGas'] != null ? map['valueGas'] as num : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceValueModel.fromJson(String source) => DeviceValueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceValueModel(id: $id, status: $status, valueHeat: $valueHeat, valueMoisture: $valueMoisture, valueGas: $valueGas, date: $date)';
  }

  @override
  bool operator ==(covariant DeviceValueModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.status == status &&
      other.valueHeat == valueHeat &&
      other.valueMoisture == valueMoisture &&
      other.valueGas == valueGas &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      status.hashCode ^
      valueHeat.hashCode ^
      valueMoisture.hashCode ^
      valueGas.hashCode ^
      date.hashCode;
  }
}
