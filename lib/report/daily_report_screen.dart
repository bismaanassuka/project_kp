import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../widgets/custom_total_card.dart';
import '../widgets/custom_transaction_card.dart';
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
  Map<String, List<Map<String, dynamic>>> _dailyTransactions = {};
  Map<String, double>? _totals;

  @override
  void initState() {
    super.initState();
    print('DailyReportScreen UserId: ${widget.userId}');
    _controller = DailyReportController(widget.userId, const FlutterSecureStorage());
    _fetchDailyTransactions();
    _fetchTotals();
  }

  Future<void> _fetchDailyTransactions() async {
    final transactions = await _controller.getDailyTransactions(_selectedDate);
    if (transactions != null) {
      setState(() {
        _dailyTransactions = _groupTransactionsByDate(transactions);
      });
    }
  }

  Map<String, List<Map<String, dynamic>>> _groupTransactionsByDate(Map<String, dynamic> transactions) {
    Map<String, List<Map<String, dynamic>>> groupedTransactions = {};

    List<Map<String, dynamic>> incomeTransactions = List<Map<String, dynamic>>.from(transactions['income']);
    List<Map<String, dynamic>> expenseTransactions = List<Map<String, dynamic>>.from(transactions['expense']);

    for (var transaction in incomeTransactions) {
      String date = transaction['date'].substring(0, 10); // Ambil tanggal (YYYY-MM-DD)
      if (groupedTransactions[date] == null) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]!.add({
        'type': 'income',
        'transaction': transaction,
      });
    }

    for (var transaction in expenseTransactions) {
      String date = transaction['date'].substring(0, 10); // Ambil tanggal (YYYY-MM-DD)
      if (groupedTransactions[date] == null) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]!.add({
        'type': 'expense',
        'transaction': transaction,
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _totals == null || _dailyTransactions.isEmpty
          ? const Center(child: CircularProgressIndicator())
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                      _fetchDailyTransactions();
                    });
                  },
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded),
                      const SizedBox(width: 8),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.add(const Duration(days: 1));
                      _fetchDailyTransactions();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Daftar Transaksi', style: primaryText2),
            const SizedBox(height: 8),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    List<Widget> transactionWidgets = [];

    if (_dailyTransactions.isEmpty) {
      transactionWidgets.add(
        const Center(
          child: Text('Tidak ada transaksi untuk tanggal ini.'),
        ),
      );
    } else {
      _dailyTransactions.forEach((date, transactions) {
        transactionWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  date,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ...transactions.map((transaction) => TransactionCard(
                title: transaction['transaction']['title'],
                date: transaction['transaction']['date'],
                amount: transaction['transaction']['amount'].toString(),
                color: transaction['transaction']['color'],
              )),
            ],
          ),
        );
      });
    }

    return Column(
      children: transactionWidgets,
    );
  }
}
