import 'package:dio/dio.dart';

class AddTransactionController {
  final String userId;

  AddTransactionController(this.userId);

  Future<bool> addTransaction(bool isIncome, String title, String amount, String description, DateTime date) async {
    final dio = Dio();
    final url = isIncome
        ? 'https://d4f2-114-5-104-222.ngrok-free.app/api/incomes'
        : 'https://d4f2-114-5-104-222.ngrok-free.app/api/expanse';

    print('Attempting to post to: $url');
    print('Data: {user_id: $userId, name: $title, amount: $amount, date_time: ${date.toIso8601String()}, description: $description}');

    try {
      final response = await dio.post(
        url,
        data: {
          'user_id': userId,
          'name': title,
          'amount': double.parse(amount),
          'date_time': date.toIso8601String(),
          'description': description,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      return response.statusCode == 200;
    } catch (e) {
      if (e is DioError) {
        print('Dio error: ${e.message}');
        if (e.response != null) {
          print('Dio response status: ${e.response?.statusCode}');
          print('Dio response data: ${e.response?.data}');
        } else {
          print('Dio error without response: ${e.message}');
        }
      } else {
        print('Unexpected error: $e');
      }
      return false;
    }
  }

}
