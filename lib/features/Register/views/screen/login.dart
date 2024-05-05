import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maasapp/core/widgets/reusable_widgets/reusable.dart';
import 'package:maasapp/features/Register/views/screen/forgetPass.dart';
import 'package:maasapp/features/Register/views/screen/registerr.dart';
import 'package:maasapp/features/Register/views/screen/Home.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final  _email = TextEditingController();
  final  _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153158),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
        title: const Text("L O G I N"),
      ),
    
      body: Container(
        color: const Color(0xFF153158),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(
                  children: <Widget> [
                    logoWidget("assets/images/LoginPic.jpg"),
                    const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter your email", Icons.person_outline, false,
                    _email),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _password),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "L O G I N ", () async {
                 await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email.text,
                          password: _password.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
               registerrOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //void signInUser(BuildContext context) async {
    //try {
      //await FirebaseAuth.instance.signInWithEmailAndPassword(
        //email: _email.text,
        //password: _password.text
      //);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    //} catch (error) {
      //print("Error ${error.toString()}");
    //}
  //}

  Row registerrOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
          },
          child: const Text(" Register ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }


  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}