import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CircularChart extends StatelessWidget {
  final double incomePercentage;
  final double expensePercentage;

  const CircularChart({
    Key? key,
    required this.incomePercentage,
    required this.expensePercentage,
  }) : super(key: key);

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
                  value: incomePercentage,
                  title: '${incomePercentage.toStringAsFixed(0)}%',
                  radius: 50,
                  titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                ),
                PieChartSectionData(
                  color: Colors.white,
                  value: expensePercentage,
                  title: '${expensePercentage.toStringAsFixed(0)}%',
                  radius: 50,
                  titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
              centerSpaceRadius: 40,
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
                  '6.000.000', // This value should be dynamic based on data
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
