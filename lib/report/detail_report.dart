import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../widgets/custom_chart.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';
import '../widgets/indicator_widget.dart';
import 'controller/detail_report_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DetailReport extends StatefulWidget {
  final dynamic loginController;
  final Map<String, dynamic> report;

  const DetailReport({
    Key? key,
    required this.loginController,
    required this.report,
  }) : super(key: key);

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  late final DetailReportController _controller;
  Map<String, dynamic>? _detailReport;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = DetailReportController(const FlutterSecureStorage());
    _fetchDetailReport();
  }

  Future<void> _fetchDetailReport() async {
    try {
      final detailReport = await _controller.getDetailReport(
        widget.report['year'],
        widget.report['month'],
      );
      if (mounted) {
        setState(() {
          _detailReport = detailReport;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle error, e.g., show error message to the user
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_detailReport == null) {
      return Scaffold(
        body: Center(child: Text('Failed to load report data')),
      );
    }

    final totalIncome = _detailReport!['total_income'];
    final totalExpenses = _detailReport!['total_expenses'];
    final incomePercentage = (totalIncome / (totalIncome + totalExpenses)) * 100;
    final expensePercentage = (totalExpenses / (totalIncome + totalExpenses)) * 100;

    return Scaffold(
      body: SingleChildScrollView(
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
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 60, bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              '${_detailReport!['month']}, ${_detailReport!['year']}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            CircularChart(
                              incomePercentage: incomePercentage,
                              expensePercentage: expensePercentage,
                            ),
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
                                  amount: 'Rp. ${totalIncome.toString()}',
                                  icon: Icons.input_rounded,
                                  color: Colors.green,
                                  color2: green2,
                                ),
                                TotalCard(
                                  title: 'Pengeluaran',
                                  amount: 'Rp. ${totalExpenses.toString()}',
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
                            itemCount: (_detailReport!['transactions'] as List).length,
                            itemBuilder: (context, index) {
                              final transaction = (_detailReport!['transactions'] as List)[index];
                              return TransactionCard(
                                title: transaction['name'],
                                date: transaction['date_time'],
                                amount: transaction['amount'].toString(),
                                color: transaction['type'] == 'income'
                                    ? Colors.green
                                    : Colors.red,
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
      bottomNavigationBar: CustomNavbar(loginController: widget.loginController),
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
