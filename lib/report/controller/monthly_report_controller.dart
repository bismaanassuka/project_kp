import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MonthlyReportController {
  final String userId;
  final FlutterSecureStorage secureStorage;

  MonthlyReportController(this.userId, this.secureStorage);

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<Map<String, dynamic>?> getMonthlyReport() async {
    final dio = Dio();
    final url = 'https://ef13-61-5-57-84.ngrok-free.app/api/monthly-report/monthly-report';

    try {
      final token = await _getToken();
      if (token == null) {
        print('Error: No token found');
        return null;
      }

      final response = await dio.get(
        url,
        queryParameters: {
          'user_id': userId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
        print('Response Data: $responseData');

        // Process your monthly report data here and return it
        return responseData;
      } else {
        print('Failed to fetch monthly report data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
