import 'package:flutter/material.dart';
import 'package:solidwaste_app/update_profile.dart';


class HomePage extends StatelessWidget {
  final String userName = 'John';

  const HomePage({super.key}); // Replace 'John' with the user's first name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to update profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateProfilePage(userName: '', userProfilePicture: '',)),
                );
              },
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/img/profile_pic.jpg'),
                    // Add a placeholder image if the profile picture is not available
                    // backgroundColor: Colors.grey,
                    // child: Icon(Icons.person, color: Colors.white, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Hello, $userName',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

