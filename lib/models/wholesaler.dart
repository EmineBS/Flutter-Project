class Wholesaler {
  final int id;
  final String username;
  final String email;
  final String password;
  final Profile profile;
  final DateTime createdAt;

  Wholesaler({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profile,
    required this.createdAt,
  });

  // Factory constructor for creating a Wholesaler instance from JSON
  factory Wholesaler.fromJson(Map<String, dynamic> json) {
    return Wholesaler(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      profile: Profile.fromJson(json['profile']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert a Wholesaler instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profile': profile.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Profile {
  final String name;
  final String phone;
  final String companyName;
  final String address;
  final String userType;

  Profile({
    required this.name,
    required this.phone,
    required this.companyName,
    required this.address,
    required this.userType,
  });

  // Factory constructor for creating a Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      companyName: json['companyName'] ?? '',
      address: json['address'] ?? '',
      userType: json['userType'] ?? 'wholesaler',
    );
  }

  // Convert a Profile instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'companyName': companyName,
      'address': address,
      'userType': userType,
    };
  }
}
