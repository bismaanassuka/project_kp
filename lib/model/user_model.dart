class User {
  final int userId;
  final String name;
  final String email;
  final String access_token;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.access_token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Extract the 'user' object from the JSON response
    var userJson = json['user'];

    return User(
      userId: userJson['id'], // Use 'id' instead of 'user_id'
      name: userJson['name'],
      email: userJson['email'],
      access_token: json['token'], // Assuming 'token' is the remember_token
    );
  }
}
