import 'package:flutter/material.dart';
import '../screens/login_screen.dart'; // Import the login screen
import '../screens/poll_creation_screen.dart';
import '../screens/poll_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/create_poll', // Set the initial route to the login screen
      routes: {
        '/': (context) => LoginScreen(), // Change to LoginScreen
        '/create_poll': (context) => PollCreationScreen(),
        '/poll_list': (context) =>
            PollListScreen(), // Add a route for PollListScreen
      },
    );
  }
}
