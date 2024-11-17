class Auth {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String role;
  final String password; // Should be handled securely in practice
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLogin;

  Auth({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.role,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    this.lastLogin,
  });

  // Factory constructor to create an Auth object from a JSON map
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
    );
  }

  // Method to convert an Auth object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'role': role,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }
}
