// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'center_model.dart';

class FireBrigadePofileModel {
  final CenterModel? center;
  final int? id;
  final String? name;
  final String? email;
  final int? numberOfTeam;
  final String? createdAt;
  final String? updatedAt;
  FireBrigadePofileModel({
    this.center,
    this.id,
    this.name,
    this.email,
    this.numberOfTeam,
    this.createdAt,
    this.updatedAt,
  });

  FireBrigadePofileModel copyWith({
    CenterModel? center,
    int? id,
    String? name,
    String? email,
    int? numberOfTeam,
    String? createdAt,
    String? updatedAt,
  }) {
    return FireBrigadePofileModel(
      center: center ?? this.center,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      numberOfTeam: numberOfTeam ?? this.numberOfTeam,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'center': center?.toMap(),
      'id': id,
      'name': name,
      'email': email,
      'numberOfTeam': numberOfTeam,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FireBrigadePofileModel.fromMap(Map<String, dynamic> map) {
    return FireBrigadePofileModel(
      center: map['center'] != null
          ? CenterModel.fromMap(map['center'] as Map<String, dynamic>)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      numberOfTeam:
          map['numberOfTeam'] != null ? map['numberOfTeam'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireBrigadePofileModel.fromJson(String source) =>
      FireBrigadePofileModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireBrigadeModel(center: $center, id: $id, name: $name, email: $email, numberOfTeam: $numberOfTeam, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FireBrigadePofileModel other) {
    if (identical(this, other)) return true;

    return other.center == center &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.numberOfTeam == numberOfTeam &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return center.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        numberOfTeam.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
