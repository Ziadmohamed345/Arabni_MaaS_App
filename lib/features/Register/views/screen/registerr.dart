import 'package:flutter/material.dart';
import 'package:maasapp/core/widgets/reusable_widgets/reusable.dart';
//import 'package:maasapp/core/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maasapp/features/Register/views/screen/Home.dart';
//import 'firebase_options.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _number;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _number = TextEditingController();
  }



  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _password.dispose();
    _number.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF153158),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
        elevation: 0,
        title: const Text(
          "R E G I S T E R",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          color: const Color(0xFF153158),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.transparent,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your first name", Icons.person_outline, false,
                    _firstname),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your last name", Icons.person_outline, false,
                    _lastname),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your email", Icons.lock_outlined, true,
                    _email),
                const SizedBox(
                  height: 20,
                ),
                 reusableTextField("Enter your password", Icons.lock_outlined, true,
                    _password),
                const SizedBox(
                  height: 20,
                ),
                 reusableTextField("Enter your phone number", Icons.lock_outlined, true,
                    _number),
                const SizedBox(
                  height: 20,
                ),
                
                firebaseUIButton(context, "Register", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email.text,
                          password: _password.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
