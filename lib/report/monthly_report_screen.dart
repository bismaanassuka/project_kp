import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../auth/controller/login_controller.dart';
import '../widgets/button_card.dart';
import '../theme/text_theme.dart';
import 'controller/monthly_report_controller.dart';

class MonthlyReportScreen extends StatefulWidget {
  final String userId;

  MonthlyReportScreen({required this.userId});

  @override
  _MonthlyReportScreenState createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  late final MonthlyReportController _controller;
  Map<String, dynamic>? _monthlyReport;

  @override
  void initState() {
    super.initState();
    print('MonthlyReportScreen UserId: ${widget.userId}');
    _controller = MonthlyReportController(widget.userId, const FlutterSecureStorage());
    _fetchMonthlyReport();
  }

  Future<void> _fetchMonthlyReport() async {
    final report = await _controller.getMonthlyReport();
    if (mounted) {
      setState(() {
        _monthlyReport = report;
      });
    }
  }

  @override
  void dispose() {
    // Perform any necessary cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Report'),
      ),
      body: _monthlyReport == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
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
                                    'Rp ${_monthlyReport!['total_income'].toString()}',
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
                                    '- Rp ${_monthlyReport!['total_expense'].toString()}',
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
                                    'Rp ${_monthlyReport!['profit'].toString()}',
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
                              arguments: widget.userId,
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
