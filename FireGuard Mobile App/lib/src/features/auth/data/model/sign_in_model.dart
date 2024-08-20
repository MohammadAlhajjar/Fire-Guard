// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignInModel {
  final String username;
  final String password;
  SignInModel({
    required this.username,
    required this.password,
  });

  SignInModel copyWith({
    String? username,
    String? password,
  }) {
    return SignInModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory SignInModel.fromMap(Map<String, dynamic> map) {
    return SignInModel(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInModel.fromJson(String source) =>
      SignInModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignInModel(username: $username, password: $password)';

  @override
  bool operator ==(covariant SignInModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
