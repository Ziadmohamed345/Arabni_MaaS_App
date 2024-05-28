import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/manageAccount/');
            },
            child: Text('Manage Account'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/feedback/');
            },
            child: Text('Feedback'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/helpCenter/');
            },
            child: Text('Help Center'),
          ),
          Spacer(), // To push the Logout button to the bottom
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login/', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Red color for the logout button
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
