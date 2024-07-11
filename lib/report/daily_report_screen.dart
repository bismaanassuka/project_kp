import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
//import '../controller/daily_report_controller.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';
import 'controller/daily_report_controller.dart';

class DailyReportScreen extends StatefulWidget {
  final String userId;

  const DailyReportScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _DailyReportScreenState createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends State<DailyReportScreen> {
  late final DailyReportController _controller;
  late DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> _dailyTransactions = [];
  Map<String, double>? _totals;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = DailyReportController(
        widget.userId, const FlutterSecureStorage(), Dio());
    _fetchDailyTransactions();
    _fetchTotals();
  }

  Future<void> _fetchDailyTransactions() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      final transactions =
      await _controller.getDailyTransactions(_selectedDate);
      setState(() {
        _dailyTransactions = _groupTransactionsByDate(transactions ?? {});
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _groupTransactionsByDate(
      Map<String, dynamic>? transactions) {
    List<Map<String, dynamic>> groupedTransactions = [];
    if (transactions == null) return groupedTransactions;

    List<Map<String, dynamic>> incomeTransactions =
    List<Map<String, dynamic>>.from(transactions['income'] ?? []);
    List<Map<String, dynamic>> expenseTransactions =
    List<Map<String, dynamic>>.from(transactions['expense'] ?? []);

    for (var transaction in incomeTransactions) {
      String date = transaction['date'].substring(0, 10); // YYYY-MM-DD
      if (date == _selectedDate.toString().substring(0, 10)) {
        groupedTransactions
            .add({'type': 'income', 'transaction': transaction});
      }
    }

    for (var transaction in expenseTransactions) {
      String date = transaction['date'].substring(0, 10); // YYYY-MM-DD
      if (date == _selectedDate.toString().substring(0, 10)) {
        groupedTransactions
            .add({'type': 'expense', 'transaction': transaction});
      }
    }

    return groupedTransactions;
  }

  Future<void> _fetchTotals() async {
    final totals = await _controller.getTotalIncomesAndExpenses();
    setState(() {
      _totals = totals;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fetchDailyTransactions();
      });
    }
  }

  void _handleDeleteTransaction(int transactionId, bool isIncome) async {
    bool success = await _controller.deleteTransaction(transactionId, isIncome);
    if (success) {
      _fetchDailyTransactions();
    } else {
      // Handle failure
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _totals == null || _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TotalCard(
                    title: 'Pemasukan',
                    amount: _totals!['income']!.toStringAsFixed(2),
                    icon: Icons.input_rounded,
                    color: Colors.green,
                    color2: green2,
                  ),
                  TotalCard(
                    title: 'Pengeluaran',
                    amount: _totals!['expense']!.toStringAsFixed(2),
                    icon: Icons.output_rounded,
                    color: Colors.red,
                    color2: red2,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.subtract(Duration(days: 1));
                      _fetchDailyTransactions();
                    });
                  },
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded),
                      SizedBox(width: 8),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.add(Duration(days: 1));
                      _fetchDailyTransactions();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Daftar Transaksi', style: primaryText2),
            ),
            SizedBox(height: 8),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    if (_dailyTransactions.isEmpty) {
      return Center(
        child: Text('Tidak ada transaksi untuk tanggal ini.'),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _dailyTransactions.length,
        itemBuilder: (context, index) {
          var transaction = _dailyTransactions[index];
          print('Transaction data: $transaction'); // Add this line

          if (transaction.containsKey('transaction')) {
            int transactionId = transaction['transaction']['id'] ?? 0;
            bool isIncome = transaction['type'] == 'income';
            print('Transaction ID: $transactionId, Is Income: $isIncome'); // Add this line

            return TransactionCard(
              key: ValueKey<int>(transactionId),
              title: transaction['transaction']['title'] ?? '',
              date: transaction['transaction']['date'] ?? '',
              amount: transaction['transaction']['amount']?.toString() ?? '',
              color: isIncome ? Colors.green : Colors.red,
              onDelete: () {
                _handleDeleteTransaction(transactionId, isIncome);
              },
            );
          } else {
            return SizedBox(); // Return an empty widget if transaction data is invalid
          }
        },
      );
    }
  }


}

