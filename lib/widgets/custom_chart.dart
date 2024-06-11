
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CircularChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Color(0XFFA5C6D1),
                    value: 75,
                    title: '60%',
                    radius: 4,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  PieChartSectionData(
                    color: Colors.white,
                    value: 25,
                    title: '40%',
                    radius: 1,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
                centerSpaceRadius: 70,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    '6.000.000',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}