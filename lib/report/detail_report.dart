import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../transaction/add_transaction_screen.dart';
import '../widgets/custom_chart.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';

class DetailReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
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
                        padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              'Mei, 2024',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 16),
                            CircularChart(),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IndicatorWidget(
                                  color: Color(0XFFA5C6D1),
                                  text: 'Pemasukan',
                                ),
                                SizedBox(width: 16),
                                IndicatorWidget(
                                  color: Colors.white,
                                  text: 'Pengeluaran',
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TotalCard(
                                  title: 'Pemasukan',
                                  amount: 'Rp.19,980,00',
                                  icon: Icons.input_rounded,
                                  color: Colors.green,
                                  color2: green2,
                                ),
                                TotalCard(
                                  title: 'Pengeluaran',
                                  amount: 'Rp.13,980,00',
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
                    padding: EdgeInsets.only(left: 20, right: 20, top: 470),
                    child: Column(
                      children: [
                        Text('Daftar Transaksi', style: primaryText2),
                        Expanded(
                          child: ListView(
                            children: [
                              TransactionCard(
                                title: 'Adobe Illustrator',
                                date: '22 Mei, 2024',
                                amount: '-Rp 32.0000,-',
                                color: Colors.red,
                              ),
                              TransactionCard(
                                title: 'Dribbble',
                                date: '22 Mei, 2024',
                                amount: '-Rp 15.000.000,-',
                                color: Colors.red,
                              ),
                              TransactionCard(
                                title: 'Sony Camera',
                                date: '22 Mei, 2024',
                                amount: '-Rp 1.500.000,-',
                                color: Colors.red,
                              ),
                              TransactionCard(
                                title: 'Paypal',
                                date: '22 Mei, 2024',
                                amount: '+Rp 32.000.000,-',
                                color: Colors.green,
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
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          // Handle floating action button press here
          // For example, navigate to AddTransScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blueAccent,
            child: Column(
              children: [
                Text(
                  'Mei, 2024',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 16),
                CircularChart(),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IndicatorWidget(
                      color: Colors.greenAccent,
                      text: 'Pemasukan',
                    ),
                    SizedBox(width: 16),
                    IndicatorWidget(
                      color: Colors.redAccent,
                      text: 'Pengeluaran',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  final Color color;
  final String text;

  IndicatorWidget({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
