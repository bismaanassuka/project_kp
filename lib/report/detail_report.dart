// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../auth/controller/login_controller.dart';
// import '../theme/colors.dart';
// import '../widgets/button_card.dart';
// import '../theme/text_theme.dart';
// import '../widgets/custom_navbar.dart';
// import '../widgets/custom_total_card.dart';
// import '../widgets/custom_transaction_card.dart';
// import '../widgets/indicator_widget.dart';
// import 'controller/detail_report_controller.dart'; // Import controller for API call
//
// class DetailReport extends StatefulWidget {
//   final LoginController loginController;
//   final Map<String, dynamic> report; // Receive report data from MonthlyReportScreen
//
//   const DetailReport({Key? key, required this.loginController, required this.report}) : super(key: key);
//
//   @override
//   _DetailReportState createState() => _DetailReportState();
// }
//
// class _DetailReportState extends State<DetailReport> {
//   late final DetailReportController _controller;
//   bool _isLoading = false;
//   Map<String, dynamic>? _detailReportData;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = DetailReportController(const FlutterSecureStorage());
//     _fetchDetailReport();
//   }
//
//   Future<void> _fetchDetailReport() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final year = widget.report['year']; // Get year from report data
//       final month = widget.report['month'] as int; // Ambil bulan sebagai int dari report
//       // Get month from report data
//
//       final detailReport = await _controller.getDetailReport(year, month);
//
//       setState(() {
//         _detailReportData = detailReport;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching detail report: $e');
//       setState(() {
//         _isLoading = false;
//         // Handle error, e.g., show error message to the user
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Report'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _detailReportData == null
//           ? Center(child: Text('Failed to fetch detail report'))
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(color: Colors.white),
//               constraints: BoxConstraints.expand(
//                 height: MediaQuery.of(context).size.height,
//               ),
//               child: Stack(
//                 children: <Widget>[
//                   FractionallySizedBox(
//                     widthFactor: 1.0,
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       'assets/images/bg_report2.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
//                         child: Column(
//                           children: [
//                             Text(
//                               '${widget.report['monthName']}, ${widget.report['year']}',
//                               style: TextStyle(color: Colors.white, fontSize: 20),
//                             ),
//                             SizedBox(height: 16),
//                             SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IndicatorWidget(
//                                   color: Color(0XFFA5C6D1),
//                                   text: 'Pemasukan',
//                                 ),
//                                 SizedBox(width: 16),
//                                 IndicatorWidget(
//                                   color: Colors.white,
//                                   text: 'Pengeluaran',
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 TotalCard(
//                                   title: 'Pemasukan',
//                                   amount: 'Rp ${_detailReportData!['total_income']}',
//                                   icon: Icons.input_rounded,
//                                   color: Colors.green,
//                                   color2: green2,
//                                 ),
//                                 TotalCard(
//                                   title: 'Pengeluaran',
//                                   amount: 'Rp ${_detailReportData!['total_expenses']}',
//                                   icon: Icons.output_rounded,
//                                   color: Colors.red,
//                                   color2: red2,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 20, right: 20, top: 470),
//                     child: Column(
//                       children: [
//                         Text('Daftar Transaksi', style: primaryText2),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: _detailReportData!['transactions'].length,
//                             itemBuilder: (context, index) {
//                               final transaction = _detailReportData!['transactions'][index];
//
//                               return TransactionCard(
//                                 title: transaction['title'],
//                                 date: transaction['date'],
//                                 amount: transaction['amount'],
//                                 color: transaction['type'] == 'income' ? Colors.green : Colors.red, id: null,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomNavbar(loginController: widget.loginController), // Pass loginController here
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/add_transaction');
//         },
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
