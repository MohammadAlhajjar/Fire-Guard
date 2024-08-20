
import 'dart:convert';

class FireBrigade {
  final int? id;
  final String? name;
  FireBrigade({
    this.id,
    this.name,
  });

  FireBrigade copyWith({
    int? id,
    String? name,
  }) {
    return FireBrigade(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory FireBrigade.fromMap(Map<String, dynamic> map) {
    return FireBrigade(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireBrigade.fromJson(String source) => FireBrigade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FireBrigade(id: $id, name: $name)';

  @override
  bool operator ==(covariant FireBrigade other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
