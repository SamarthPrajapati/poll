import 'package:flutter/material.dart';
import '../models/poll.dart'; // Import the Poll model
import '../services/api_service.dart'; // Import the API service
import 'poll_creation_screen.dart'; // Import the PollCreationScreen

class PollListScreen extends StatefulWidget {
  @override
  _PollListScreenState createState() => _PollListScreenState();
}

class _PollListScreenState extends State<PollListScreen> {
  List<Poll> _polls = []; // Initialize empty list
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPolls(); // Fetch polls when the screen initializes
    _scrollController.addListener(_scrollListener);
  }

  // Function to fetch polls from the API
  void _fetchPolls() async {
    try {
      String token = ''; // Get token from authentication service or storage
      List<dynamic>? pollsData = await APIService.fetchPolls(token);

      if (pollsData != null) {
        setState(() {
          _polls = pollsData!.map((data) => Poll.fromJson(data)).toList();
        });
      } else {
        // Handle null response
        print('Error fetching polls: Response body is null');
      }
    } catch (e) {
      // Handle error
      print('Error fetching polls: $e');
    }
  }

  // Function to handle infinite scrolling
  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // At the bottom of the list
      _fetchPolls(); // Fetch more polls
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Polls'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _polls.length + 1,
        itemBuilder: (context, index) {
          if (index < _polls.length) {
            return Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange), // Add border
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _polls[index].topic,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _polls[index].question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Display options in boxes with transparent orange color fill
                  Column(
                    children: _polls[index].textOptions.map((option) {
                      return InkWell(
                        onTap: () {
                          // Handle option selection
                        },
                        onHover: (hovering) {
                          // Handle hover effect
                          setState(() {
                            if (hovering) {
                              // Increase size when hovering
                              _polls[index].textOptions.forEach((element) {
                                if (element == option) {
                                  element = '* ' + element + ' *';
                                }
                              });
                            } else {
                              // Reset size when not hovering
                              _polls[index].textOptions.forEach((element) {
                                if (element.startsWith('* ') &&
                                    element.endsWith(' *')) {
                                  element =
                                      element.substring(2, element.length - 2);
                                }
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
              // Show loading indicator while fetching polls
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        // Set background color to black
        selectedItemColor: Colors.orange,
        // Set selected item color to orange
        unselectedItemColor: Colors.white,
        // Set unselected item color to white
        currentIndex: 1,
        // Specify the selected index
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Poll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Polls',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to PollCreationScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PollCreationScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../models/poll.dart'; // Import the Poll model
// import '../services/api_service.dart'; // Import the API service
// import 'poll_creation_screen.dart'; // Import the PollCreationScreen

// class PollListScreen extends StatefulWidget {
//   @override
//   _PollListScreenState createState() => _PollListScreenState();
// }

// class _PollListScreenState extends State<PollListScreen> {
//   List<Poll> _polls = []; // Initialize empty list

//   @override
//   void initState() {
//     super.initState();
//     _fetchPolls(); // Fetch polls when the screen initializes
//   }

//   // Function to fetch polls from the API
//   void _fetchPolls() async {
//     try {
//       String token = ''; // Get token from authentication service or storage
//       List<dynamic> pollsData = await APIService.fetchPolls(token);

//       setState(() {
//         _polls = pollsData.map((data) => Poll.fromJson(data)).toList();
//       });
//     } catch (e) {
//       // Handle error
//       print('Error fetching polls: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Simulate dummy data if polls are not fetched
//     if (_polls.isEmpty) {
//       _polls = [
//         Poll(
//           topic: 'Dummy Topic 1',
//           question: 'Dummy Question 1?',
//           pollType: 'MCQ', // Dummy poll type
//           textOptions: ['Option 1', 'Option 2', 'Option 3'], // Dummy options
//           isAnonymous: false,
//           id: '', // Dummy isAnonymous value
//         ),
//         Poll(
//           topic: 'Dummy Topic 2',
//           question: 'Dummy Question 2?',
//           pollType: 'Picture', // Dummy poll type
//           textOptions: ['Option A', 'Option B'], // Dummy options
//           isAnonymous: true,
//           id: '', // Dummy isAnonymous value
//         ),
//         Poll(
//           topic: 'Dummy Topic 3',
//           question: 'Dummy Question 3?',
//           pollType: 'Picture', // Dummy poll type
//           textOptions: ['Option A', 'Option B'], // Dummy options
//           isAnonymous: true,
//           id: '', // Dummy isAnonymous value
//         ),
//         Poll(
//           topic: 'Dummy Topic 4',
//           question: 'Dummy Question 4?',
//           pollType: 'Picture', // Dummy poll type
//           textOptions: ['Option A', 'Option B'], // Dummy options
//           isAnonymous: true,
//           id: '', // Dummy isAnonymous value
//         ),
//         Poll(
//           topic: 'Dummy Topic 5',
//           question: 'Dummy Question 5?',
//           pollType: 'Picture', // Dummy poll type
//           textOptions: ['Option A', 'Option B'], // Dummy options
//           isAnonymous: true,
//           id: '', // Dummy isAnonymous value
//         ),
//         Poll(
//           topic: 'Dummy Topic 6',
//           question: 'Dummy Question 6?',
//           pollType: 'Picture', // Dummy poll type
//           textOptions: ['Option A', 'Option B'], // Dummy options
//           isAnonymous: true,
//           id: '', // Dummy isAnonymous value
//         ),
//       ];
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Polls'),
//         backgroundColor: Colors.orange, // Change app bar color to black
//       ),
//       backgroundColor: Colors.black,
//       body: _polls.isNotEmpty
//           ? ListView.builder(
//               itemCount: _polls.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.all(16.0),
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.orange), // Add border
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         _polls[index].topic,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18.0,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       Text(
//                         _polls[index].question,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Colors.white, // Set text color to white
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       // Display options in boxes with transparent orange color fill
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: _polls[index].textOptions.length,
//                         itemBuilder: (context, optionIndex) {
//                           return InkWell(
//                             onTap: () {
//                               // Handle option selection
//                             },
//                             onHover: (hovering) {
//                               // Handle hover effect
//                             },
//                             child: Container(
//                               margin: EdgeInsets.symmetric(vertical: 4.0),
//                               padding: EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.withOpacity(0.3),
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                               child: Text(
//                                 _polls[index].textOptions[optionIndex],
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//               // Show loading indicator while fetching polls
//             ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.black,
//         // Set background color to black
//         selectedItemColor: Colors.orange,
//         // Set selected item color to orange
//         unselectedItemColor: Colors.white,
//         // Set unselected item color to white
//         currentIndex: 1,
//         // Specify the selected index
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Create Poll',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.poll),
//             label: 'Polls',
//           ),
//         ],
//         onTap: (index) {
//           if (index == 0) {
//             // Navigate to PollCreationScreen
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PollCreationScreen(),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
