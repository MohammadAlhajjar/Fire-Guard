// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'device_model.dart';
import 'forest_model.dart';
import 'status_model.dart';



// fire_model.dart
class FireModel {
  final int? id;
  final StatusModel? status;
  final ForestModel? forest;
  final DeviceModel? device;
  final String? updatedAt;
  final String? createdAt;
  FireModel({
    this.id,
    this.status,
    this.forest,
    this.device,
    this.updatedAt,
    this.createdAt,
  });

  FireModel copyWith({
    int? id,
    StatusModel? status,
    ForestModel? forest,
    DeviceModel? device,
    String? updatedAt,
    String? createdAt,
  }) {
    return FireModel(
      id: id ?? this.id,
      status: status ?? this.status,
      forest: forest ?? this.forest,
      device: device ?? this.device,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status?.toMap(),
      'forest': forest?.toMap(),
      'device': device?.toMap(),
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory FireModel.fromMap(Map<String, dynamic> map) {
    return FireModel(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? StatusModel.fromMap(map['status'] as Map<String,dynamic>) : null,
      forest: map['forest'] != null ? ForestModel.fromMap(map['forest'] as Map<String,dynamic>) : null,
      device: map['device'] != null ? DeviceModel.fromMap(map['device'] as Map<String,dynamic>) : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireModel.fromJson(String source) => FireModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireModel(id: $id, status: $status, forest: $forest, device: $device, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant FireModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.status == status &&
      other.forest == forest &&
      other.device == device &&
      other.updatedAt == updatedAt &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      status.hashCode ^
      forest.hashCode ^
      device.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;
  }
}
