import 'package:flutter/material.dart';
import '../screens/poll_creation_screen.dart';
import '../services/auth_service.dart'; // Import the AuthService

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

  // Function to handle form submission
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Perform authentication
      String phoneNumber = _phoneNumberController.text;
      String otp = _otpController.text;

      try {
        String? token = await AuthService.authenticateUser(phoneNumber, otp);
        if (token == null) {
          // Authentication successful, navigate to PollCreationScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PollCreationScreen(),
            ),
          );
        } else {
          // Authentication failed, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Authentication failed. Please try again.'),
            ),
          );
        }
      } catch (e) {
        // Handle authentication failure or error
        print('Authentication failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.orange), // Underline color
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  labelText: 'OTP',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.orange), // Underline color
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isSubmitting ? null : () => _submitForm(context),
                child:
                    _isSubmitting ? CircularProgressIndicator() : Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
