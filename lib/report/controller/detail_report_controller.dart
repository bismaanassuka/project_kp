import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config.dart'; // Pastikan Anda mengganti import ini sesuai dengan lokasi file config.dart Anda

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
        queryParameters: {
          'year': year,
          'month': month,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        final parsedData = {
          'year': data['year'],
          'month': data['month'],
          'total_income': double.parse(data['total_income']),
          'total_expenses': double.parse(data['total_expenses']),
          'remaining_balance': double.parse(data['remaining_balance']),
          'transactions': data['transactions'],
        };

        return parsedData;
      } else {
        print('Failed to fetch detail report data, status code: ${response.statusCode}');
        throw Exception('Failed to fetch detail report data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch detail report data');
    }
  }
}
