import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.email),
                    iconColor: Colors.white),
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
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.lock),
                    iconColor: Colors.white),
              ),
              const SizedBox(height: 16.0),
             
              TextButton(
                  onPressed: () async {
                   //Navigator.of(context).pushNamedAndRemoveUntil('/screen/', (route) => false);
                    final email = _email.text;
                    final password = _password.text;
                    try{
                      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                      print(userCredential);

                    } on FirebaseAuthException catch (e) {
                      if(e.code == 'user-not-found') {
                        print('user not found');
                      } else{
                        print('Something Happened');
                        print(e.code);
                      }

                    }
                    
                  }, 
                  child: const Text("Login")
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
                    },
                    child: const Text('Register From Here'),
                  )

            ],
          ),
        ),
      ),
    );
  }


 
  }

