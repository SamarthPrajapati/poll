import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'poll_list_screen.dart'; // Import PollListScreen

class PollCreationScreen extends StatefulWidget {
  @override
  _PollCreationScreenState createState() => _PollCreationScreenState();
}

class _PollCreationScreenState extends State<PollCreationScreen> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _optionsControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<String> _options = [];
  String? _pollType; // Define _pollType variable

  void _createPoll() async {
    String topic = _topicController.text;
    String question = _questionController.text;

    Map<String, dynamic> pollData = {
      'topic': topic,
      'question': question,
      'poll_type': _pollType, // Pass poll type
      'text_options': _options,
      'is_anonymous': false,
    };

    try {
      String token = ''; // Get token from authentication service or storage
      await APIService.createPoll(token, pollData);
      // Handle success, e.g., navigate to another screen
    } catch (e) {
      // Handle error, e.g., display error message
      print('Error creating poll: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moderators Poll'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  child: Text(
                    'Create Poll',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              // Topic text field
              Text(
                'Topic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                controller: _topicController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Write here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.black,
                  filled: true,
                  hintMaxLines: 5,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Statement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ), // Statement text field
              TextFormField(
                controller: _questionController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Write here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.black,
                  filled: true,
                  hintMaxLines: 5,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                // Radio buttons in one line
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('MCQ Poll',
                          style: TextStyle(color: Colors.white)),
                      value: 'MCQ',
                      activeColor: Colors.orange,
                      groupValue: _pollType,
                      onChanged: (value) {
                        setState(() {
                          _pollType = value as String;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Picture Poll',
                          style: TextStyle(color: Colors.white)),
                      value: 'Picture',
                      activeColor: Colors.orange,
                      groupValue: _pollType,
                      onChanged: (value) {
                        setState(() {
                          _pollType = value as String;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Rate It Poll',
                          style: TextStyle(color: Colors.white)),
                      value: 'RateIt',
                      activeColor: Colors.orange,
                      groupValue: _pollType,
                      onChanged: (value) {
                        setState(() {
                          _pollType = value as String;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Option text fields
              for (int i = 0; i < 4; i++)
                TextFormField(
                  controller: _optionsControllers[i],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Option ${i + 1}',
                    fillColor: Colors.black,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.orange), // Set underline color to orange
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.orange), // Set underline color to orange
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        // Clear text field
                        _optionsControllers[i].clear();
                      },
                    ),
                  ),
                ),
              SizedBox(height: 16.0),
              // Submit button
              ElevatedButton(
                onPressed: _createPoll,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Set button color to orange
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Set background color to black
        selectedItemColor: Colors.orange, // Set selected item color to orange
        unselectedItemColor: Colors.white, // Set unselected item color to white
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add), // Add icon
            label: 'Create Poll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll), // Poll icon
            label: 'Poll List',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            // Navigate to PollCreationScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PollCreationScreen(),
              ),
            );
          } else if (index == 1) {
            // Navigate to PollListScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PollListScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
