import 'package:Webcare/auth/profile_screen.dart';
import 'package:Webcare/report/daily_report_screen.dart';
import 'package:Webcare/report/detail_report.dart';
import 'package:Webcare/report/report_screen.dart';
import 'package:Webcare/splash_screen.dart';
import 'package:Webcare/transaction/add_transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailReport(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
    );
  }
}