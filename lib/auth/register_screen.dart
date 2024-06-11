import 'package:Webcare/auth/login_screen.dart';
import 'package:Webcare/theme/text_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/custom_button.dart';
import 'auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _confPass = '';
  bool _isLoading = false;
  bool _isObscure = true;
  bool _isObscure2 = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Simulate a login process
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Handle login logic here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_auth.png"),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(height: 50),
                    Text('Registrasi', style: headingText),
                    Text('Daftar dan Mulai Catat Keuanganmu!', style: primaryText),
                    SizedBox(height: 200),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.mail),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure2 ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscure2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }else if(_confPass!=_password){
                          return 'Password Incorrect!';
                        }
                        return null;
                      },
                      onChanged: (_confPass) {
                        setState(() {
                          _confPass = _password;
                        });
                      },
                    ),
                    SizedBox(height: 80),
                    CustomButton(
                        buttonText: 'DAFTAR',
                        onPressed: _submit
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sudah memiliki akun? ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextSpan(
                              text: 'Masuk',
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  navigateToScreen(context, LoginScreen());
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))
            ])));
  }
}