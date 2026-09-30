import 'user_role.dart';

class Customer {
  final int id;
  final String name;
  final String email;
  final UserRole role;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role.name,
  };

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere((role) => role.name == json['role']),
    );
  }
}
