import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../widgets/custom_chart.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';
import '../widgets/indicator_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    final report = widget.report;
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
                              '${report['month']}, ${report['year']}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            CircularChart(),
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
                                  amount: 'Rp. ${report['total_income'].toString()}',
                                  icon: Icons.input_rounded,
                                  color: Colors.green,
                                  color2: green2,
                                ),
                                TotalCard(
                                  title: 'Pengeluaran',
                                  amount: 'Rp. ${report['total_expenses'].toString()}',
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
                            itemCount: (report['transactions'] as List).length,
                            itemBuilder: (context, index) {
                              final transaction = (report['transactions'] as List)[index];
                              return TransactionCard(
                                title: transaction['name'],
                                date: transaction['date_time'],
                                amount: transaction['amount'],
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
