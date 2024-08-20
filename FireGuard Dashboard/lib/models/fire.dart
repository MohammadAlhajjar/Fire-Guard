// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Fire {
  final int? id;
  final String? createsAt;
  final String? latitude;
  final String? longitude;
  final String? nameAddress;
  Fire({
    this.id,
    this.createsAt,
    this.latitude,
    this.longitude,
    this.nameAddress,
  });

  Fire copyWith({
    int? id,
    String? createsAt,
    String? latitude,
    String? longitude,
    String? nameAddress,
  }) {
    return Fire(
      id: id ?? this.id,
      createsAt: createsAt ?? this.createsAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      nameAddress: nameAddress ?? this.nameAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createsAt': createsAt,
      'latitude': latitude,
      'longitude': longitude,
      'nameAddress': nameAddress,
    };
  }

  factory Fire.fromMap(Map<String, dynamic> map) {
    return Fire(
      id: map['id'] != null ? map['id'] as int : null,
      createsAt: map['createsAt'] != null ? map['createsAt'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      nameAddress: map['nameAddress'] != null ? map['nameAddress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fire.fromJson(String source) => Fire.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Fire(id: $id, createsAt: $createsAt, latitude: $latitude, longitude: $longitude, nameAddress: $nameAddress)';
  }

  @override
  bool operator ==(covariant Fire other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.createsAt == createsAt &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.nameAddress == nameAddress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      createsAt.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      nameAddress.hashCode;
  }
}
