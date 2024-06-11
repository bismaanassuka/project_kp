import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;
  final Color color2;

  TotalCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    required this.color2
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna bayangan
            spreadRadius: 1, // Radius penyebaran bayangan
            blurRadius: 5, // Radius blur bayangan
            offset: Offset(0, 2), // Offset bayangan (dx, dy)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );

  }
}