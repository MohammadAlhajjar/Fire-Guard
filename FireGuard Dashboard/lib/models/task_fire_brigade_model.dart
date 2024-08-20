// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'fire.dart';
import 'fire_brigade_model.dart';

class TaskFireBrigadeModel {
  final Fire? fire;
  final FireBrigadeModel? fireBrigade;
  final int? id;
  final String? note;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  TaskFireBrigadeModel({
    this.fire,
    this.fireBrigade,
    this.id,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  TaskFireBrigadeModel copyWith({
    Fire? fire,
    FireBrigadeModel? fireBrigade,
    int? id,
    String? note,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaskFireBrigadeModel(
      fire: fire ?? this.fire,
      fireBrigade: fireBrigade ?? this.fireBrigade,
      id: id ?? this.id,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fire': fire?.toMap(),
      'fireBrigade': fireBrigade?.toMap(),
      'id': id,
      'note': note,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TaskFireBrigadeModel.fromMap(Map<String, dynamic> map) {
    return TaskFireBrigadeModel(
      fire: map['fire'] != null ? Fire.fromMap(map['fire'] as Map<String,dynamic>) : null,
      fireBrigade: map['fireBrigade'] != null ? FireBrigadeModel.fromMap(map['fireBrigade'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      note: map['note'] != null ? map['note'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskFireBrigadeModel.fromJson(String source) => TaskFireBrigadeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskFireBrigadeModel(fire: $fire, fireBrigade: $fireBrigade, id: $id, note: $note, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant TaskFireBrigadeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.fire == fire &&
      other.fireBrigade == fireBrigade &&
      other.id == id &&
      other.note == note &&
      other.status == status &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return fire.hashCode ^
      fireBrigade.hashCode ^
      id.hashCode ^
      note.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
