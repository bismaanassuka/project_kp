import 'package:Webcare/report/report_screen.dart';
import 'package:Webcare/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReportScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}