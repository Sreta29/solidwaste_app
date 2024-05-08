//import 'dart:io';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:solidwaste_app/homepage.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage(
      {super.key,
      required String userName,
      required String userProfilePicture});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  bool changePage = false;

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  late String _name, _userName, _email, _password, _confirmPassword, _address;

  @override
  Widget build(BuildContext context) {
    if (changePage) {
      return const HomePage(
        key: null,
      );
    }
    return Scaffold(
        appBar: AppBar(
          // Display the back button in the app bar
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
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
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
                        width: 150, // Set the width as per your requirement
                        height: 50, // Set the height as per your requirement
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Update Profile'),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ));
  }
}
