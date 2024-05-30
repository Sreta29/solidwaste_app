import 'package:flutter/material.dart';
import 'homepage.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    super.key,
    required this.userName,
    required this.userProfilePicture,
  });

  final String userName;
  final String userProfilePicture;

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  bool changePage = false;
  late String _name, _userName, _email, _password, _confirmPassword, _address;

  final _formKey = GlobalKey<FormState>();

  // Function to handle profile picture update
  void _updateProfilePicture() {
    // Implement your logic to update the profile picture here
  }

  // Function to update profile
  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call your function to update the profile with _name, _email, etc.
      _updateProfileDetails(_name, _userName, _email, _password, _address);
    }
  }

  // Function to update profile details
  void _updateProfileDetails(String name, String userName, String email, String password, String address) {
    // Implement your logic to update the profile with the provided details
    print('Updating profile with name: $name, userName: $userName, email: $email, password: $password, address: $address');
  }

  @override
  Widget build(BuildContext context) {
    if (changePage) {
      return const HomePage(key: null);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              changePage = !changePage;
            });
          },
        ),
        title: const Text('Update Profile Page'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _updateProfilePicture, // Call the update function here
                child: const CircleAvatar(
                  radius: 50,
                  foregroundImage: AssetImage('assets/image/profile-user.png'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'User Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },
                onSaved: (value) => _userName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (value) => _confirmPassword = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _updateProfile, // Call the function to update profile here
                        child: const Text('Update Profile'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

