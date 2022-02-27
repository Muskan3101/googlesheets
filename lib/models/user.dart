import 'dart:convert';

class UserFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';

  static List<String> getFields() => [id, name, email];
}

class User {
  final int? id;
  final String name;
  final String email;

  //Constructor

  const User({
    this.id,
    required this.name,
    required this.email,
  });

// copy method
  User copy({int? id, String? name, String? email}) => User(
      id: id ?? this.id, name: name ?? this.name, email: email ?? this.email);

  //fromJson method
  static User fromJson(Map<String, dynamic> json) => User(
    id: jsonDecode(json[UserFields.id]),
    name: json[UserFields.name],
    email: json[UserFields.email],
  );

  //Json Method
  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
      };
}
