import 'dart:convert';

class CreateOrUpdateDeviceModel {
  final String? name;
  final String? description;
  final String? forest;
  final String? longitude;
  final String? latitude;
  final String? nameAddress;
  CreateOrUpdateDeviceModel({
    this.name,
    this.description,
    this.forest,
    this.longitude,
    this.latitude,
    this.nameAddress,
  });

  CreateOrUpdateDeviceModel copyWith({
    String? name,
    String? description,
    String? forest,
    String? longitude,
    String? latitude,
    String? nameAddress,
  }) {
    return CreateOrUpdateDeviceModel(
      name: name ?? this.name,
      description: description ?? this.description,
      forest: forest ?? this.forest,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      nameAddress: nameAddress ?? this.nameAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'forest': forest,
      'longitude': longitude,
      'latitude': latitude,
      'nameAddress': nameAddress,
    };
  }

  factory CreateOrUpdateDeviceModel.fromMap(Map<String, dynamic> map) {
    return CreateOrUpdateDeviceModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      forest: map['forest'] != null ? map['forest'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      nameAddress:
          map['nameAddress'] != null ? map['nameAddress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrUpdateDeviceModel.fromJson(String source) =>
      CreateOrUpdateDeviceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateDeviceModel(name: $name, description: $description, forest: $forest, longitude: $longitude, latitude: $latitude, nameAddress: $nameAddress)';
  }

  @override
  bool operator ==(covariant CreateOrUpdateDeviceModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.forest == forest &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.nameAddress == nameAddress;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        forest.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        nameAddress.hashCode;
  }
}
