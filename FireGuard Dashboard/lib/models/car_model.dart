// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:FireGuad/models/center_model.dart';

class CarModel {
  final CenterModel? center;
  final int? id;
  final String? name;
  final String? model;
  final String? numberPlate;
  final String? createdAt;
  final String? updatedAt;
  CarModel({
    this.center,
    this.id,
    this.name,
    this.model,
    this.numberPlate,
    this.createdAt,
    this.updatedAt,
  });

  CarModel copyWith({
    CenterModel? center,
    int? id,
    String? name,
    String? model,
    String? numberPlate,
    String? createdAt,
    String? updatedAt,
  }) {
    return CarModel(
      center: center ?? this.center,
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      numberPlate: numberPlate ?? this.numberPlate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'center': center?.toMap(),
      'id': id,
      'name': name,
      'model': model,
      'numberPlate': numberPlate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      center: map['center'] != null ? CenterModel.fromMap(map['center'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      numberPlate: map['numberPlate'] != null ? map['numberPlate'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) => CarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarModel(center: $center, id: $id, name: $name, model: $model, numberPlate: $numberPlate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CarModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.center == center &&
      other.id == id &&
      other.name == name &&
      other.model == model &&
      other.numberPlate == numberPlate &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return center.hashCode ^
      id.hashCode ^
      name.hashCode ^
      model.hashCode ^
      numberPlate.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
