//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maasapp/features/Register/views/screen/page.dart';
//import 'firebase_options.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // Define the firebaseUIButton method
  Widget firebaseUIButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('L O G I N '),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
        backgroundColor: const Color(0xFF153158), // Use const for static text
      ),
      body: Container(
        color: const Color(0xFF153158),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  icon: Icon(Icons.email),
                  iconColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  icon: Icon(Icons.lock),
                  iconColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              firebaseUIButton(context, "Log In", () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _email.text,
                    password: _password.text,
                  );
                  print("User signed in successfully");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Screen()),
                  );
                } catch (error) {
                  print("Error signing in: $error");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text(
                            "Failed to sign in. Please check your credentials."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
              const SizedBox(height: 16.0),
              //RegisterButton(), // Use the new RegisterButton widget
            ],
          ),
        ),
      ),
    );
  }
}


