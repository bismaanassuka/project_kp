class User {
  final int userId;
  final String name;
  final String email;
  final String rememberToken;

  User({required this.userId, required this.name, required this.email, required this.rememberToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      rememberToken: json['remember_token'],
    );
  }
}
