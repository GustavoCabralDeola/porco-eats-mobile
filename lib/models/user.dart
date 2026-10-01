import 'package:porco_eats/models/enums/user_role.dart';

class User {
  final String name;
  final String email;
  final String password;
  final UserRole role;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.role = UserRole.customer,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'role': role.name,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      password: (json['password'] as String?) ?? '',
      role: _roleFromString(json['role'] as String?),
    );
  }

  static UserRole _roleFromString(String? roleString) {
    if (roleString == null) return UserRole.customer;
    try {
      return UserRole.values.firstWhere(
        (role) => role.name == roleString,
        orElse: () => UserRole.customer,
      );
    } catch (e) {
      return UserRole.customer;
    }
  }
}
