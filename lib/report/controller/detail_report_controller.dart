import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config.dart';

class DetailReportController {
  final FlutterSecureStorage secureStorage;

  DetailReportController(this.secureStorage);

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<Map<String, dynamic>?> getDetailReport(int year, int month) async {
    final dio = Dio();
    final url = '$baseUrl/monthly-report/detail-monthly-report';

    try {
      final token = await _getToken();
      if (token == null) {
        print('Error: No token found');
        return null;
      }

      final response = await dio.get(
        url,
        queryParameters: {'year': year, 'month': month},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final parsedData = {
          'year': data['year'] is int ? data['year'] : int.parse(data['year']),
          'month': data['month'] ?? '',
          'total_income': data['total_income'] is int
              ? data['total_income']
              : (data['total_income'] is double
              ? data['total_income'].toInt()
              : double.parse(data['total_income']).toInt()),
          'total_expenses': data['total_expenses'] is int
              ? data['total_expenses']
              : (data['total_expenses'] is double
              ? data['total_expenses'].toInt()
              : double.parse(data['total_expenses']).toInt()),
          'remaining_balance': data['remaining_balance'] is int
              ? data['remaining_balance']
              : (data['remaining_balance'] is double
              ? data['remaining_balance'].toInt()
              : double.parse(data['remaining_balance']).toInt()),
          'transactions': data['transactions'] is List
              ? List<Map<String, dynamic>>.from(data['transactions'])
              : [],
        };

        return parsedData;
      } else {
        print('Failed to fetch detail report data: ${response.statusCode} ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
