import 'package:Webcare/theme/colors.dart';
import 'package:Webcare/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedIndex = 0;

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAPORAN', style: appBarText),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ToggleButtons(
                fillColor: primaryColor,
                selectedColor: Colors.white,
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                onPressed: _onToggle,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Harian', style: secondaryText),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Bulanan', style: secondaryText,),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: _selectedIndex == 0 ? DailyReportPage() : MonthlyReportPage(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add transaction logic
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class DailyReportPage extends StatelessWidget {
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
                SummaryCard(
                  title: 'Pemasukan',
                  amount: 'Rp.19,980,00',
                  icon: Icons.download_rounded,
                  color: Colors.green,
                ),
                SummaryCard(
                  title: 'Pengeluaran',
                  amount: 'Rp.13,980,00',
                  icon: Icons.upload_rounded,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Daftar Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

class MonthlyReportPage extends StatelessWidget {
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
                SummaryCard(
                  title: 'Pemasukan',
                  amount: 'Rp.199,800,00',
                  icon: Icons.download_rounded,
                  color: Colors.green,
                ),
                SummaryCard(
                  title: 'Pengeluaran',
                  amount: 'Rp.139,800,00',
                  icon: Icons.upload_rounded,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Daftar Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  TransactionCard(
                    title: 'Adobe Illustrator',
                    date: '22 Mei, 2024',
                    amount: '-Rp 320.0000,-',
                    color: Colors.red,
                  ),
                  TransactionCard(
                    title: 'Dribbble',
                    date: '22 Mei, 2024',
                    amount: '-Rp 1.500.000,-',
                    color: Colors.red,
                  ),
                  TransactionCard(
                    title: 'Sony Camera',
                    date: '22 Mei, 2024',
                    amount: '-Rp 15.000.000,-',
                    color: Colors.red,
                  ),
                  TransactionCard(
                    title: 'Paypal',
                    date: '22 Mei, 2024',
                    amount: '+Rp 320.000.000,-',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final Color color;

  TransactionCard({
    required this.title,
    required this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(Icons.repeat, color: color),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
