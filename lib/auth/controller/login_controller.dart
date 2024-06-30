import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../model/user_model.dart';
import '../../report/report_screen.dart';

class LoginController {

  String token;
  LoginController({required this.token});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late User _user;

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      var data = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        isLoading = true;
        Dio dio = Dio();
        var response = await dio.post(
          'https://d4f2-114-5-104-222.ngrok-free.app/api/login',
          data: data,
        );

        print("Response status: ${response.statusCode}");
        print("Response data: ${response.data}");

        isLoading = false;

        if (response.statusCode == 200) {
          if (response.data != null && response.data is Map<String, dynamic>) {
            _user = User.fromJson(response.data);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login successful")),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportScreen(loginController: this),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid response format")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login failed")),
          );
        }
      } catch (e) {
        isLoading = false;
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: $e")),
        );
      }
    }
  }

  User get user => _user;
}
