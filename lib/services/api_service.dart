import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = 'https://dev.stance.live/api';

  // Function to authenticate user and obtain authentication token
  static Future<String?> authenticateUser(
      String phoneNumber, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/end-user/verify-otp'),
      body: jsonEncode({'otp': otp, 'phone_number': phoneNumber}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token 430772ad06439c4e010d80f5b714dfe2630b7216',
      },
    );

    if (response.statusCode == 200) {
      int statusCode = response.statusCode;
      print('Status code: $statusCode');
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  // Function to create a new poll
  static Future<Map<String, dynamic>> createPoll(
      String token, Map<String, dynamic> pollData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/polls/'),
      headers: {
        'Authorization': 'Token 430772ad06439c4e010d80f5b714dfe2630b7216',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(pollData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to create poll: ${response.statusCode}');
    }
  }

  // Function to fetch polls
  static Future<List<dynamic>> fetchPolls(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/polls/'),
      headers: {
        'Authorization': 'Token 430772ad06439c4e010d80f5b714dfe2630b7216'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> pollsData =
          responseData['polls']; // Extract polls data
      return pollsData;
    } else {
      throw Exception('Failed to fetch polls: ${response.statusCode}');
    }
  }
}
