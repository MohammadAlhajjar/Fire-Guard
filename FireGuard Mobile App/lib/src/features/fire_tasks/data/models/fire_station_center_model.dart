// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
class FireStationCenterModel {
  final int? id;
  final String? name;
  final String? description;
  final String? phoneNumber;
  final String? status;
  final String? nameAddress;
  final String? longitude;
  final String? latitude;
  final String? createdAt;
  final String? updatedAt;
  FireStationCenterModel({
    this.id,
    this.name,
    this.description,
    this.phoneNumber,
    this.status,
    this.nameAddress,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
  });

  FireStationCenterModel copyWith({
    int? id,
    String? name,
    String? description,
    String? phoneNumber,
    String? status,
    String? nameAddress,
    String? longitude,
    String? latitude,
    String? createdAt,
    String? updatedAt,
  }) {
    return FireStationCenterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      nameAddress: nameAddress ?? this.nameAddress,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'status': status,
      'nameAddress': nameAddress,
      'longitude': longitude,
      'latitude': latitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FireStationCenterModel.fromMap(Map<String, dynamic> map) {
    return FireStationCenterModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      nameAddress: map['nameAddress'] != null ? map['nameAddress'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireStationCenterModel.fromJson(String source) => FireStationCenterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireStationCenterModel(id: $id, name: $name, description: $description, phoneNumber: $phoneNumber, status: $status, nameAddress: $nameAddress, longitude: $longitude, latitude: $latitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FireStationCenterModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.phoneNumber == phoneNumber &&
      other.status == status &&
      other.nameAddress == nameAddress &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      phoneNumber.hashCode ^
      status.hashCode ^
      nameAddress.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
