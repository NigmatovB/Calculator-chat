// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;

class SmsServices {
  static Uri url = Uri.parse('https://chat-add.herokuapp.com/');

  static Future<List<dynamic>> fetSms() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode( response.body );
      } else {
        throw Exception('Failed to load sms');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> postSms( item ) async {
    try {
      final response = await http.post(
        url,
        body: jsonEncode( item ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString());
      } else {
        throw Exception('Failed to load sms');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
