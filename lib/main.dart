import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.email),
                    iconColor: Colors.white),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _password,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 20), // Set title color
                    icon: Icon(Icons.lock),
                    iconColor: Colors.white),
                obscureText: true,
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
            ],
          ),
        ),
      ),
    );
  }
}
