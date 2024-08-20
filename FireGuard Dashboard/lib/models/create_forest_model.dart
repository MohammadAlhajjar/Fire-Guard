// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateOrUpdateForestModel {
  final String? name;
  final String? description;
  final String? latitude;
  final String? longitude;
  final String? nameAddress;
  CreateOrUpdateForestModel({
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.nameAddress,
  });

  CreateOrUpdateForestModel copyWith({
    String? name,
    String? description,
    String? latitude,
    String? longitude,
    String? nameAddress,
  }) {
    return CreateOrUpdateForestModel(
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      nameAddress: nameAddress ?? this.nameAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'nameAddress': nameAddress,
    };
  }

  factory CreateOrUpdateForestModel.fromMap(Map<String, dynamic> map) {
    return CreateOrUpdateForestModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      nameAddress:
          map['nameAddress'] != null ? map['nameAddress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrUpdateForestModel.fromJson(String source) =>
      CreateOrUpdateForestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateForestModel(name: $name, description: $description, latitude: $latitude, longitude: $longitude, nameAddress: $nameAddress)';
  }

  @override
  bool operator ==(covariant CreateOrUpdateForestModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.nameAddress == nameAddress;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        nameAddress.hashCode;
  }
}
