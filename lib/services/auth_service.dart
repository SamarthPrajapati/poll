import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static final String _baseUrl = 'https://dev.stance.live/api';
  static final String _accessTokenUrl = '$_baseUrl/authenticate';
  static final String _verifyOtpUrl = '$_baseUrl/end-user/verify-otp';
  static final String _tokenName = 'strings_token';

  static Future<String?> authenticateUser(
      String phoneNumber, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(_accessTokenUrl),
        body: jsonEncode({
          'username': phoneNumber,
          'password': otp
        }), // Updated to use phoneNumber and otp
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Authentication successful, parse and return access token
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData[_tokenName];
      } else {
        // Authentication failed, return null
        return null;
      }
    } catch (e) {
      // Error occurred during API call
      return null;
    }
  }

  static Future<bool> verifyOTP(String otp, String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse(_verifyOtpUrl),
        body: jsonEncode({
          'otp': otp,
          'phone_number': phoneNumber
        }), // Use phoneNumber instead of _username
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      // Error occurred during API call
      return false;
    }
  }
}
