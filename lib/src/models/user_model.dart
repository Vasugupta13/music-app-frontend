
import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  final String? name;
  final String? email;
  final String? id;
  final int? v;

  User({
    this.name,
    this.email,
    this.id,
    this.v,
  });

  User copyWith({
    String? name,
    String? email,
    String? id,
    int? v,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        id: id ?? this.id,
        v: v ?? this.v,
      );

  factory User.fromMap(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "_id": id,
    "__v": v,
  };
}
