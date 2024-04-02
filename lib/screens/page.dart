import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'New Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 192, 208)),
        useMaterial3: true,
      ),
      home: const Screen (),
    ),
  );
}

class Screen extends StatelessWidget {
  const Screen({super.key});

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
        child: const Padding(
          padding: EdgeInsets.all(16.0),

        ),
      ),
    );
  }
}