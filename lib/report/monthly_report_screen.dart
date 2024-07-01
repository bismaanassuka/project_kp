import 'package:flutter/material.dart';
import 'package:Webcare/auth/controller/login_controller.dart';
import 'package:Webcare/model/user_model.dart'; // Adjust according to your project structure
import '../widgets/button_card.dart'; // Adjust according to your project structure
import '../theme/text_theme.dart'; // Adjust according to your project structure

class MonthlyReportScreen extends StatelessWidget {
  final User user;

  MonthlyReportScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Report'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1 Mei 2024 - 31 Mei 2024',
                                style: primaryText2.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pemasukkan',
                                    style: primaryText2.copyWith(fontSize: 14),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Rp 250.000',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pengeluaran',
                                    style: primaryText2.copyWith(fontSize: 14),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    '- Rp 10.000',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Profit',
                                    style: primaryText2.copyWith(fontSize: 14),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Rp 240.000',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ButtonCard(
                          buttonText: 'Lihat Detail',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/detail_report',
                              arguments: user,
                            );
                          },
                          loginController: LoginController(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
