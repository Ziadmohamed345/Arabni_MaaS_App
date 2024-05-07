// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController _oldPassword;
  late final TextEditingController _newPassword;
  late final TextEditingController _confirmPassword;


  @override
  void initState() {
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color.fromARGB(255, 4, 24, 50),
        leading: IconButton(
          icon: const Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.white),
              SizedBox(width: 4), // Adding space between icon and text
            ],
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 4, 24, 50),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 1),
              const Text(
                'Arabni',
                style: TextStyle(
                  color: Color.fromARGB(255, 238, 50, 53),
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Enhancing Urban Mobility',
                style: TextStyle(
                  color: Color.fromARGB(255, 249, 248, 248),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Create New Password",
                style: TextStyle(
                  color: Color.fromARGB(255, 249, 248, 248),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _oldPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter Old Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5), // Corrected padding values
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _newPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter New Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5), // Corrected padding values
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5), // Corrected padding values
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final oldPassword = _oldPassword.text;
                  final newPassword = _newPassword.text;
                  final confirmPassword = _confirmPassword.text;

                  if (newPassword == confirmPassword) {
                    if (newPassword == oldPassword) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Password Unchanged'),
                            content: const Text('The new password is the same as the old password.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      final auth = FirebaseAuth.instance;
                      final currentUser = auth.currentUser;
                      final database = FirebaseDatabase.instance.reference();

                      if (currentUser != null) {
                        final credential = EmailAuthProvider.credential(email: currentUser.email!, password: oldPassword);
                        try {
                          await auth.currentUser!.reauthenticateWithCredential(credential);
                          DataSnapshot snapshot = (await database.child('users').child(currentUser.uid).child('password').once()) as DataSnapshot;
                          final existingPassword = snapshot.value.toString();

                          if (existingPassword == newPassword) {
                            print('Password already used by another user.'); // Debug message
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Password Already Used'),
                                  content: const Text('The new password is already in use.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            await auth.currentUser!.updatePassword(newPassword);
                            Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
                          }
                        } catch (e) {
                          print('Error: $e'); // Debug message for reauthentication error
                        }
                      }
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Passwords Mismatch'),
                          content: const Text('The new password and confirm password do not match.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 253, 251, 251),
                  backgroundColor: const Color.fromARGB(255, 238, 50, 53),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: const Text('Confirm'),
              ),
              const SizedBox(height: 0.5),
              Image.asset(
                'assets/images/LoginPic.jpg',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}