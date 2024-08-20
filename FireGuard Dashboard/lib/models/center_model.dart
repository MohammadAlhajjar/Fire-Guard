// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CenterModel {
  final int? id;
  final String? name;
  final String? description;
  final String? phoneNumber;
  final String? status;
  final String? nameAddress;
  final String? latitude;
  final String? longitude;
  final String? createdAt;
  final String? updatedAt;
  CenterModel({
    this.id,
    this.name,
    this.description,
    this.phoneNumber,
    this.status,
    this.nameAddress,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  CenterModel copyWith({
    int? id,
    String? name,
    String? description,
    String? phoneNumber,
    String? status,
    String? nameAddress,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
  }) {
    return CenterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
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
      'phoneNumber': phoneNumber,
      'status': status,
      'nameAddress': nameAddress,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CenterModel.fromMap(Map<String, dynamic> map) {
    return CenterModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      nameAddress: map['nameAddress'] != null ? map['nameAddress'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CenterModel.fromJson(String source) => CenterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CenterModel(id: $id, name: $name, description: $description, phoneNumber: $phoneNumber, status: $status, nameAddress: $nameAddress, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CenterModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.phoneNumber == phoneNumber &&
      other.status == status &&
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
      phoneNumber.hashCode ^
      status.hashCode ^
      nameAddress.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
