// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StatusModel {
  final String? label;
  final String? value;
  StatusModel({
    this.label,
    this.value,
  });

  StatusModel copyWith({
    String? label,
    String? value,
  }) {
    return StatusModel(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'value': value,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      label: map['label'] != null ? map['label'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusModel.fromJson(String source) => StatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StatusModel(label: $label, value: $value)';

  @override
  bool operator ==(covariant StatusModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.label == label &&
      other.value == value;
  }

  @override
  int get hashCode => label.hashCode ^ value.hashCode;
}
