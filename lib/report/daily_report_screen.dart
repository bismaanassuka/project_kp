import 'package:Webcare/report/report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';

class DailyReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Implement navigation logic
                  },
                ),
                Text(
                  'December 2022',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Implement navigation logic
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            Text('Daftar Transaksi', style: primaryText2),
            SizedBox(height: 8),
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
        )
    );
  }
}