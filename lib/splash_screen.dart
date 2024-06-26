import 'package:Webcare/auth/login_screen.dart';
import 'package:Webcare/report/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    autoLogin();
    super.initState();
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString("user-token");
    if (userToken != null) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReportScreen()));
      });
    }else{
      Future.delayed(Duration(seconds: 5),()
      {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            height: 180,
            width: 120,
          ),
        ),
      ),
    );
  }
}
