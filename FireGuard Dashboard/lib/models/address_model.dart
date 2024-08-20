
import 'dart:convert';

class AddressModel {
  final int? id;
  final String? longitude;
  final String? latitude;
  final String? createdAt;
  final String? updatedAt;
  AddressModel({
    this.id,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
  });

  AddressModel copyWith({
    int? id,
    String? longitude,
    String? latitude,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] != null ? map['id'] as int : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(id: $id, longitude: $longitude, latitude: $latitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
