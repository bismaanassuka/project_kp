import 'package:Webcare/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../theme/colors.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Slidable(
        key: Key(title), // Pastikan setiap item memiliki key yang unik
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SizedBox(width: 10),
            SlidableAction(
              onPressed: (context) {
                // Lakukan aksi ketika tombol edit ditekan
                // Implementasikan logika pengeditan item di sini
              },
              backgroundColor: secondaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SizedBox(width: 10),
            SlidableAction(
              onPressed: (context) {
                // Lakukan aksi ketika tombol hapus ditekan
                // Implementasikan logika penghapusan item di sini
              },
              backgroundColor: red3,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Hapus',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(Icons.compare_arrows_rounded, color: color),
            title: Text(title, style: nameTransText),
            subtitle: Text(date),
            trailing: Text(
              amount,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
