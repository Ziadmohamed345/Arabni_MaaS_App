import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _number;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _number = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _number.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                controller: _firstname,
                decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.person),
                    iconColor: Colors.white),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _lastname,
                decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.person),
                    iconColor: Colors.white),
              ),
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
              TextField(
                controller: _number,
                decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.phone),
                    iconColor: Colors.white),
                keyboardType: TextInputType.phone,
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  //try {
                    final userCredential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    // Show success message
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Registered successfully!'),
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
                  }, //on FirebaseAuthException catch (e) {
                    //String errorMessage = 'Registration failed!';
                    //if (e.code == 'weak password') {
                      //errorMessage = 'Weak password';
                    //} else if (e.code == 'email already in use') {
                      //errorMessage = 'Email already in use';
                    //}
                    // Show error message
                    //showDialog(
                      //context: context,
                      //builder: (BuildContext context) {
                        //return AlertDialog(
                          //title: const Text('E R R O R'),
                          //content: Text(errorMessage),
                          //actions: [
                            //TextButton(
                              //onPressed: () {
                                //Navigator.of(context).pop(); // Close the dialog
                              //},
                              //child: const Text('OK'),
                            //),
                          //],
                        //);
                      //},
                    //);
                  //}
                //},
            
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
                  TextButton(
                    onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);

                  }, child: const Text("Already Registered? Login Here!" , style: TextStyle(color: Colors.white70),)
                  )
            ],
          ),
        ),
      ),
    );
  }
}