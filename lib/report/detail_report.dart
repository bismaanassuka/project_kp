import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';
import '../widgets/indicator_widget.dart';
import 'controller/monthly_report_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DetailReport extends StatefulWidget {
  final dynamic loginController;
  final String token;

  const DetailReport({super.key, required this.loginController, required this.token});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  late final MonthlyReportController _controller;
  Map<String, dynamic>? _monthlyReport;

  @override
  void initState() {
    super.initState();
    _controller = MonthlyReportController(widget.loginController.userId, const FlutterSecureStorage());
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _monthlyReport == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/bg_report2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                        child: Column(
                          children: [
                            const Text(
                              'Mei, 2024',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            // CircularChart(),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IndicatorWidget(
                                  color: const Color(0XFFA5C6D1),
                                  text: 'Pemasukan',
                                ),
                                const SizedBox(width: 16),
                                IndicatorWidget(
                                  color: Colors.white,
                                  text: 'Pengeluaran',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TotalCard(
                                  title: 'Pemasukan',
                                  amount: 'Rp. ${_monthlyReport!['total_income'].toString()}',
                                  icon: Icons.input_rounded,
                                  color: Colors.green,
                                  color2: green2,
                                ),
                                TotalCard(
                                  title: 'Pengeluaran',
                                  amount: 'Rp. ${_monthlyReport!['total_expense'].toString()}',
                                  icon: Icons.output_rounded,
                                  color: Colors.red,
                                  color2: red2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 470),
                    child: Column(
                      children: [
                        const Text('Daftar Transaksi', style: primaryText2),
                        Expanded(
                          child: ListView.builder(
                            itemCount: (_monthlyReport!['transactions'] as List).length,
                            itemBuilder: (context, index) {
                              final transaction = (_monthlyReport!['transactions'] as List)[index];
                              return TransactionCard(
                                title: transaction['name'],
                                date: transaction['date_time'],
                                amount: transaction['amount'],
                                color: transaction['type'] == 'income' ? Colors.green : Colors.red,
                              );
                            },
                          ),
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
      bottomNavigationBar: CustomNavbar(loginController: widget.loginController), // Pass loginController here
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_transaction');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
