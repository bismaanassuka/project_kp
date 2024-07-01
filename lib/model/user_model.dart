import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  final int userId;
  final String name;
  final String email;
  final String accessToken;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Extract the 'user' object from the JSON response
    var userJson = json['user'];

    return User(
      userId: userJson['id'], // Use 'id' instead of 'user_id'
      name: userJson['name'],
      email: userJson['email'],
      accessToken: json['token'], // Assuming 'token' is the remember_token
    );
  }

  Future<void> saveToken(FlutterSecureStorage secureStorage) async {
    await secureStorage.write(key: 'access_token', value: accessToken);
  }
}
