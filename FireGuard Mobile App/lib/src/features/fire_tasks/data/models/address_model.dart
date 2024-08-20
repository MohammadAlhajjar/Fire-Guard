// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
final int? id;
final String? latitude;
final String? longitude;
final String? createdAt;
  Address({
    this.id,
    this.latitude,
    this.longitude,
    this.createdAt,
  });

  Address copyWith({
    int? id,
    String? latitude,
    String? longitude,
    String? createdAt,
  }) {
    return Address(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] != null ? map['id'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, latitude: $latitude, longitude: $longitude, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      createdAt.hashCode;
  }
}