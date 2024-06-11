import 'package:Webcare/report/detail_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class ButtonCard extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;

  const ButtonCard({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            secondaryColor
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailReport()),
          );
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 50),
          backgroundColor:
          Colors.transparent,
          shadowColor: Colors
              .transparent,
          shape: RoundedRectangleBorder(
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Lihat Detail',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),
            ),
            Icon(Icons.arrow_forward_ios,
            color: Colors.white,size: 14,)
          ],
        ),
      ),
    );
  }
}