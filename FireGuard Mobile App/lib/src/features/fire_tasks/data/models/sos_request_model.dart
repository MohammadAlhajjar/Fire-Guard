// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SosRequestMdoel {
  final String? center;
  final String? status;
  final String? fire;
  final String? fireBrigade;
  SosRequestMdoel({
    this.center,
    this.status,
    this.fire,
    this.fireBrigade,
  });

  SosRequestMdoel copyWith({
    String? center,
    String? status,
    String? fire,
    String? fireBrigade,
  }) {
    return SosRequestMdoel(
      center: center ?? this.center,
      status: status ?? this.status,
      fire: fire ?? this.fire,
      fireBrigade: fireBrigade ?? this.fireBrigade,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'center': center,
      'status': status,
      'fire': fire,
      'fireBrigade': fireBrigade,
    };
  }

  factory SosRequestMdoel.fromMap(Map<String, dynamic> map) {
    return SosRequestMdoel(
      center: map['center'] != null ? map['center'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      fire: map['fire'] != null ? map['fire'] as String : null,
      fireBrigade: map['fireBrigade'] != null ? map['fireBrigade'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SosRequestMdoel.fromJson(String source) => SosRequestMdoel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SosRequestMdoel(center: $center, status: $status, fire: $fire, fireBrigade: $fireBrigade)';
  }

  @override
  bool operator ==(covariant SosRequestMdoel other) {
    if (identical(this, other)) return true;
  
    return 
      other.center == center &&
      other.status == status &&
      other.fire == fire &&
      other.fireBrigade == fireBrigade;
  }

  @override
  int get hashCode {
    return center.hashCode ^
      status.hashCode ^
      fire.hashCode ^
      fireBrigade.hashCode;
  }
}
