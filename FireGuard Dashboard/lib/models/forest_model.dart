// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForestModel {
  final int? id;
  final String? name;
  final String? description;
  final String? nameAddress;
  final String? latitude;
  final String? longitude;
  final String? createdAt;
  final String? updatedAt;
  ForestModel({
    this.id,
    this.name,
    this.description,
    this.nameAddress,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  ForestModel copyWith({
    int? id,
    String? name,
    String? description,
    String? nameAddress,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
  }) {
    return ForestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      nameAddress: nameAddress ?? this.nameAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'nameAddress': nameAddress,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ForestModel.fromMap(Map<String, dynamic> map) {
    return ForestModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      nameAddress: map['nameAddress'] != null ? map['nameAddress'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForestModel.fromJson(String source) => ForestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForestModel(id: $id, name: $name, description: $description, nameAddress: $nameAddress, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ForestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.nameAddress == nameAddress &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      nameAddress.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
