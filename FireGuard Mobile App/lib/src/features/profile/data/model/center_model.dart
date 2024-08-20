// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CenterModel {
  final int? id;
  final String? name;
  final String? createdAt;
  CenterModel({
    this.id,
    this.name,
    this.createdAt,
  });

  CenterModel copyWith({
    int? id,
    String? name,
    String? createdAt,
  }) {
    return CenterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }

  factory CenterModel.fromMap(Map<String, dynamic> map) {
    return CenterModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CenterModel.fromJson(String source) => CenterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CenterModel(id: $id, name: $name, createdAt: $createdAt)';

  @override
  bool operator ==(covariant CenterModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;
}