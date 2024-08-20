// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:fire_guard_app/src/features/fire_tasks/data/models/address_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_brigade_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/status_model.dart';

class FireLocationOrHistoryModel {
  final Fire? fire;
  final FireBrigade? fireBrigade;
  final int? id;
  final String? note;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  FireLocationOrHistoryModel({
    this.fire,
    this.fireBrigade,
    this.id,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  FireLocationOrHistoryModel copyWith({
    Fire? fire,
    FireBrigade? fireBrigade,
    int? id,
    String? note,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return FireLocationOrHistoryModel(
      fire: fire ?? this.fire,
      fireBrigade: fireBrigade ?? this.fireBrigade,
      id: id ?? this.id,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fire': fire?.toMap(),
      'fireBrigade': fireBrigade?.toMap(),
      'id': id,
      'note': note,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FireLocationOrHistoryModel.fromMap(Map<String, dynamic> map) {
    return FireLocationOrHistoryModel(
      fire: map['fire'] != null ? Fire.fromMap(map['fire'] as Map<String,dynamic>) : null,
      fireBrigade: map['fireBrigade'] != null ? FireBrigade.fromMap(map['fireBrigade'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      note: map['note'] != null ? map['note'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireLocationOrHistoryModel.fromJson(String source) => FireLocationOrHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireLocationOrHistoryModel(fire: $fire, fireBrigade: $fireBrigade, id: $id, note: $note, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FireLocationOrHistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.fire == fire &&
      other.fireBrigade == fireBrigade &&
      other.id == id &&
      other.note == note &&
      other.status == status &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return fire.hashCode ^
      fireBrigade.hashCode ^
      id.hashCode ^
      note.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

class ForestModel {
  final int? id;
  final String? name;
  final String? createdAt;
  final Address? address;
  ForestModel({
    this.id,
    this.name,
    this.createdAt,
    this.address,
  });

  ForestModel copyWith({
    int? id,
    String? name,
    String? createdAt,
    Address? address,
  }) {
    return ForestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'address': address?.toMap(),
    };
  }

  factory ForestModel.fromMap(Map<String, dynamic> map) {
    return ForestModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForestModel.fromJson(String source) =>
      ForestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForestModel(id: $id, name: $name, createdAt: $createdAt, address: $address)';
  }

  @override
  bool operator ==(covariant ForestModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ createdAt.hashCode ^ address.hashCode;
  }
}

class DeviceModel {
  final int? id;
  final String? name;
  final String? createdAt;
  DeviceModel({
    this.id,
    this.name,
    this.createdAt,
  });

  DeviceModel copyWith({
    int? id,
    String? name,
    String? createdAt,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DeviceModel(id: $id, name: $name, createdAt: $createdAt)';

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;
}
