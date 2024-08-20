// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateOrUpdateCenterModel {
  final String? name;
  final String? description;
  final String? phoneNumber;
  final String? status;
  final String? latitude;
  final String? longitude;
  final String? nameAddress;
  CreateOrUpdateCenterModel({
    this.name,
    this.description,
    this.phoneNumber,
    this.status,
    this.latitude,
    this.longitude,
    this.nameAddress,
  });

  CreateOrUpdateCenterModel copyWith({
    String? name,
    String? description,
    String? phoneNumber,
    String? status,
    String? latitude,
    String? longitude,
    String? nameAddress,
  }) {
    return CreateOrUpdateCenterModel(
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      nameAddress: nameAddress ?? this.nameAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'nameAddress': nameAddress,
    };
  }

  factory CreateOrUpdateCenterModel.fromMap(Map<String, dynamic> map) {
    return CreateOrUpdateCenterModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      nameAddress:
          map['nameAddress'] != null ? map['nameAddress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrUpdateCenterModel.fromJson(String source) =>
      CreateOrUpdateCenterModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateCenterModel(name: $name, description: $description, phoneNumber: $phoneNumber, status: $status, latitude: $latitude, longitude: $longitude, nameAddress: $nameAddress)';
  }

  @override
  bool operator ==(covariant CreateOrUpdateCenterModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.phoneNumber == phoneNumber &&
        other.status == status &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.nameAddress == nameAddress;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        phoneNumber.hashCode ^
        status.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        nameAddress.hashCode;
  }
}
