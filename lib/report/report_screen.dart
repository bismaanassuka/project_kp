import 'package:flutter/material.dart';
import 'package:Webcare/theme/colors.dart';
import 'package:Webcare/theme/text_theme.dart';
import '../transaction/add_transaction_screen.dart';
import '../widgets/custom_navbar.dart';
import 'daily_report_screen.dart';
import 'monthly_report_screen.dart';
import 'custom_navbar.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedIndex = 0;
  final TextStyle activeTextStyle = TextStyle(color: Colors.white);
  final TextStyle inactiveTextStyle = TextStyle(color: primaryColor);

  void _onButtonPressed(int index) {
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(160, 60),
                      backgroundColor: _selectedIndex == 0 ? tertiaryColor : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(0),
                    child: Text(
                      'Harian',
                      style: primaryText.copyWith(
                        color: _selectedIndex == 0 ? primaryColor : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Tombol Bulanan
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(160, 60),
                      backgroundColor: _selectedIndex == 1 ? tertiaryColor : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(1),
                    child: Text(
                      'Bulanan',
                      style: primaryText.copyWith(
                        color: _selectedIndex == 1 ? primaryColor : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: _selectedIndex == 0 ? DailyReportScreen() : MonthlyReportScreen(),
              ),
            ],
          ),
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
