// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateFireStatusModel {
  final String? status;
  UpdateFireStatusModel({
    this.status,
  });


  UpdateFireStatusModel copyWith({
    String? status,
  }) {
    return UpdateFireStatusModel(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory UpdateFireStatusModel.fromMap(Map<String, dynamic> map) {
    return UpdateFireStatusModel(
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateFireStatusModel.fromJson(String source) => UpdateFireStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UpdateFireStatusModel(status: $status)';

  @override
  bool operator ==(covariant UpdateFireStatusModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
