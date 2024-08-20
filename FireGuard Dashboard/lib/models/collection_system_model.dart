// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'center_model.dart';
import 'device_model.dart';
import 'fire_model.dart';
import 'forest_model.dart';

class CollectionSystemModel {
  final List<CenterModel?>? centers;
  final List<FireModel?>? fires;
  final List<ForestModel?>? forestes;
  final List<DeviceModel?>? devices;
  CollectionSystemModel({
    this.centers,
    this.fires,
    this.forestes,
    this.devices,
  });

  CollectionSystemModel copyWith({
    List<CenterModel?>? centers,
    List<FireModel?>? fires,
    List<ForestModel?>? forestes,
    List<DeviceModel?>? devices,
  }) {
    return CollectionSystemModel(
      centers: centers ?? this.centers,
      fires: fires ?? this.fires,
      forestes: forestes ?? this.forestes,
      devices: devices ?? this.devices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'centers': centers?.map((x) => x?.toMap()).toList(),
      'fires': fires?.map((x) => x?.toMap()).toList(),
      'forestes': forestes?.map((x) => x?.toMap()).toList(),
      'devices': devices?.map((x) => x?.toMap()).toList(),
    };
  }

  factory CollectionSystemModel.fromMap(Map<String, dynamic> map) {
    return CollectionSystemModel(
      centers: map['centers'] != null ? List<CenterModel?>.from((map['centers'] as List<dynamic>).map<CenterModel?>((x) => CenterModel?.fromMap(x as Map<String,dynamic>),),) : null,
      fires: map['fires'] != null ? List<FireModel?>.from((map['fires'] as List<dynamic>).map<FireModel?>((x) => FireModel?.fromMap(x as Map<String,dynamic>),),) : null,
      forestes: map['forestes'] != null ? List<ForestModel?>.from((map['forestes'] as List<dynamic>).map<ForestModel?>((x) => ForestModel?.fromMap(x as Map<String,dynamic>),),) : null,
      devices: map['devices'] != null ? List<DeviceModel?>.from((map['devices'] as List<dynamic>).map<DeviceModel?>((x) => DeviceModel?.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionSystemModel.fromJson(String source) => CollectionSystemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectionSystemModel(centers: $centers, fires: $fires, forestes: $forestes, devices: $devices)';
  }

  @override
  bool operator ==(covariant CollectionSystemModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.centers, centers) &&
      listEquals(other.fires, fires) &&
      listEquals(other.forestes, forestes) &&
      listEquals(other.devices, devices);
  }

  @override
  int get hashCode {
    return centers.hashCode ^
      fires.hashCode ^
      forestes.hashCode ^
      devices.hashCode;
  }
}
