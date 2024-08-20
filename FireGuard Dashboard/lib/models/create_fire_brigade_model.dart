// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateOrUpdateFireBrigadeModel {
  final String? name;
  final int? numberOfTeam;
  final int? center;
  final String? email;
  final String? password;
  CreateOrUpdateFireBrigadeModel({
    this.name,
    this.numberOfTeam,
    this.center,
    this.email,
    this.password,
  });

  CreateOrUpdateFireBrigadeModel copyWith({
    String? name,
    int? numberOfTeam,
    int? center,
    String? email,
    String? password,
  }) {
    return CreateOrUpdateFireBrigadeModel(
      name: name ?? this.name,
      numberOfTeam: numberOfTeam ?? this.numberOfTeam,
      center: center ?? this.center,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'numberOfTeam': numberOfTeam,
      'center': center,
      'email': email,
      'password': password,
    };
  }

  factory CreateOrUpdateFireBrigadeModel.fromMap(Map<String, dynamic> map) {
    return CreateOrUpdateFireBrigadeModel(
      name: map['name'] != null ? map['name'] as String : null,
      numberOfTeam:
          map['numberOfTeam'] != null ? map['numberOfTeam'] as int : null,
      center: map['center'] != null ? map['center'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrUpdateFireBrigadeModel.fromJson(String source) =>
      CreateOrUpdateFireBrigadeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateFireBrigadeModel(name: $name, numberOfTeam: $numberOfTeam, center: $center, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant CreateOrUpdateFireBrigadeModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.numberOfTeam == numberOfTeam &&
        other.center == center &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        numberOfTeam.hashCode ^
        center.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}
