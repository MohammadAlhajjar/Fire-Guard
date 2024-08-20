// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateOrUpdateCarModel {
  final String? name;
  final String? numberPlate;
  final String? model;
  final String? center;
  CreateOrUpdateCarModel({
    this.name,
    this.numberPlate,
    this.model,
    this.center,
  });

  CreateOrUpdateCarModel copyWith({
    String? name,
    String? numberPlate,
    String? model,
    String? center,
  }) {
    return CreateOrUpdateCarModel(
      name: name ?? this.name,
      numberPlate: numberPlate ?? this.numberPlate,
      model: model ?? this.model,
      center: center ?? this.center,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'numberPlate': numberPlate,
      'model': model,
      'center': center,
    };
  }

  factory CreateOrUpdateCarModel.fromMap(Map<String, dynamic> map) {
    return CreateOrUpdateCarModel(
      name: map['name'] != null ? map['name'] as String : null,
      numberPlate:
          map['numberPlate'] != null ? map['numberPlate'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      center: map['center'] != null ? map['center'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrUpdateCarModel.fromJson(String source) =>
      CreateOrUpdateCarModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateCarModel(name: $name, numberPlate: $numberPlate, model: $model, center: $center)';
  }

  @override
  bool operator ==(covariant CreateOrUpdateCarModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.numberPlate == numberPlate &&
        other.model == model &&
        other.center == center;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        numberPlate.hashCode ^
        model.hashCode ^
        center.hashCode;
  }
}
