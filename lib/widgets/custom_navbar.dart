import 'package:flutter/material.dart';
import 'package:Webcare/theme/colors.dart';

import '../auth/profile_screen.dart';
import '../report/report_screen.dart';
import '../transaction/add_transaction_screen.dart';

class CustomNavbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: tertiaryColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 25.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildBottomNavigationItem(Icons.list_alt, 'Laporan', 0, context),
          SizedBox(width: 48.0),
          _buildBottomNavigationItem(Icons.person, 'Profil', 1, context),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String label, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: primaryColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomFloatingActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: primaryColor,
        shape: CircleBorder(),
      ),
    );
  }
}
