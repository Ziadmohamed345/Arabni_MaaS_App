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
 late final TextEditingController _id;


 @override
 void initState() {
  _email = TextEditingController();
  _password= TextEditingController();
  _firstname= TextEditingController();
  _lastname= TextEditingController();
  _number= TextEditingController();
  _id= TextEditingController();
   super.initState();
 }

 @override
 void dispose(){
  _email.dispose();
  _password.dispose();
  _firstname.dispose();
  _lastname.dispose();
  _number.dispose();
  _id.dispose();
  super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email ,
            decoration: const InputDecoration(
              hintText: 'enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: 'enter your password here',
            ),
          ),
                    TextField(
            controller: _firstname,
            decoration: const InputDecoration(
              hintText: 'enter your first name here',
            ),
          ),          TextField(
            controller: _lastname,
            decoration: const InputDecoration(
              hintText: 'enter your last name here',
            ),
          ),          TextField(
            controller: _number,
            decoration: const InputDecoration(
              hintText: 'enter your number here',
            ),
          ),
            TextField(
            controller: _id,
            decoration: const InputDecoration(
              hintText: 'enter your id here',
            ),
          ),
          TextButton(
            onPressed: () async {

            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
