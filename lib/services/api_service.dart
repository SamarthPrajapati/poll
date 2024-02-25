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
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  // Function to create a new poll
  static Future<void> createPoll(
      String token, Map<String, dynamic> pollData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/polls/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(pollData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create poll');
    }
  }

  // Function to fetch polls
  static Future<List<dynamic>> fetchPolls(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/polls/'),
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch polls');
    }
  }

  // Function to delete a poll
  static Future<void> deletePoll(String token, String pollId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/polls/$pollId/'),
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete poll');
    }
  }
}
