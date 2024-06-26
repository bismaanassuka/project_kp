import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../login_screen.dart';

class RegisterController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String username;
  late String email;
  late String password;
  bool isLoading = false;

  Future<void> submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;

      // Log untuk validasi berhasil
      print('Form validated successfully');

      // Buat instance Dio
      Dio dio = Dio();

      // Data untuk dikirim ke server
      var data = {
        "username": username,
        "email": email,
        "password": password,
      };

      // Kirim POST request ke endpoint register
      try {
        var response = await dio.post('http://192.168.43.88:8080/api/register', data: data);

        isLoading = false;

        // Handle response
        print(response.data); // Tampilkan respons dari server jika diperlukan

        // Navigasi ke LoginScreen setelah registrasi berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } catch (error) {
        isLoading = false;

        // Handle error
        print("Error: $error"); // Tampilkan pesan kesalahan jika ada
        // Tampilkan pesan kesalahan ke pengguna jika diperlukan
      }
    } else {
      // Log untuk validasi gagal
      print('Form validation failed');
    }
  }
}
