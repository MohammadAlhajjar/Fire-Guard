// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'center_model.dart';



class FireBrigadeModel {
  final int? id;
  final String? name;
  final CenterModel? center;
  final int? numberOfTeam;
  final String? email;
  final String? createdAt;
  final String? updatedAt;
  FireBrigadeModel({
    this.id,
    this.name,
    this.center,
    this.numberOfTeam,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  FireBrigadeModel copyWith({
    int? id,
    String? name,
    CenterModel? center,
    int? numberOfTeam,
    String? email,
    String? createdAt,
    String? updatedAt,
  }) {
    return FireBrigadeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      center: center ?? this.center,
      numberOfTeam: numberOfTeam ?? this.numberOfTeam,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'center': center?.toMap(),
      'numberOfTeam': numberOfTeam,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FireBrigadeModel.fromMap(Map<String, dynamic> map) {
    return FireBrigadeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      center: map['center'] != null
          ? CenterModel.fromMap(map['center'] as Map<String, dynamic>)
          : null,
      numberOfTeam:
          map['numberOfTeam'] != null ? map['numberOfTeam'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireBrigadeModel.fromJson(String source) =>
      FireBrigadeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireBrigade(id: $id, name: $name, center: $center, numberOfTeam: $numberOfTeam, email: $email, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FireBrigadeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.center == center &&
        other.numberOfTeam == numberOfTeam &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        center.hashCode ^
        numberOfTeam.hashCode ^
        email.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
