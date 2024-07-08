import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../theme/colors.dart';
import '../theme/text_theme.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final Color color;

  const TransactionCard({super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Slidable(
        key: Key(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 10),
            SlidableAction(
              onPressed: (context) {
                // Implement edit action here
              },
              backgroundColor: secondaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            const SizedBox(width: 10),
            SlidableAction(
              onPressed: (context) {
                // Implement delete action here
              },
              backgroundColor: red3,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Hapus',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
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
