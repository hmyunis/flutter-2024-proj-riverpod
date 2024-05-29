class User {
  final int? id;
  final String username;
  final String email;
  final String joinDate;
  final String role;
  final String? token;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.joinDate,
    required this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      joinDate: json['joinDate'],
      role: json['role'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, joinDate: $joinDate, role: $role, token: $token)';
  }
}
