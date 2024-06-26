import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../model/user_model.dart';
import '../../report/report_screen.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email; // Variabel untuk menyimpan email dari form
  String? password; // Variabel untuk menyimpan password dari form
  bool isLoading = false;

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      var data = {
        "email": email,
        "password": password,
      };

      try {
        isLoading = true;
        Dio dio = Dio();

        print("Sending data: $data");

        var response = await dio.post(
          'https://3d2f-120-188-81-178.ngrok-free.app/api/login',
          data: data,
        );

        print("Response status: ${response.statusCode}");
        print("Response data: ${response.data}");

        isLoading = false;

        if (response.statusCode == 200) {
          // Handle successful login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ReportScreen()),
          );
        } else {
          // Handle failed login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed")),
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
}
