// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateOrUpdateTaskFireModel {
  final String? fire;
  final String? fireBrigade;
  final String? note;
  final String? status;
  CreateOrUpdateTaskFireModel({
    this.fire,
    this.fireBrigade,
    this.note,
    this.status,
  });

  CreateOrUpdateTaskFireModel copyWith({
    String? fire,
    String? fireBrigade,
    String? note,
    String? status,
  }) {
    return CreateOrUpdateTaskFireModel(
      fire: fire ?? this.fire,
      fireBrigade: fireBrigade ?? this.fireBrigade,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fire': fire,
      'fireBrigade': fireBrigade,
      'note': note,
      'status': status,
    };
  }

  factory CreateOrUpdateTaskFireModel.fromMap(Map<String, dynamic> map) {
    return CreateOrUpdateTaskFireModel(
      fire: map['fire'] != null ? map['fire'] as String : null,
      fireBrigade:
          map['fireBrigade'] != null ? map['fireBrigade'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrUpdateTaskFireModel.fromJson(String source) =>
      CreateOrUpdateTaskFireModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateTaskFireModel(fire: $fire, fireBrigade: $fireBrigade, note: $note, status: $status)';
  }

  @override
  bool operator ==(covariant CreateOrUpdateTaskFireModel other) {
    if (identical(this, other)) return true;

    return other.fire == fire &&
        other.fireBrigade == fireBrigade &&
        other.note == note &&
        other.status == status;
  }

  @override
  int get hashCode {
    return fire.hashCode ^
        fireBrigade.hashCode ^
        note.hashCode ^
        status.hashCode;
  }
}
