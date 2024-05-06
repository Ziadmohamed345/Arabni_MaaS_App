// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:maasapp/core/utils/string_constants.dart';
//import 'package:maasapp/features/Iternairy/view models/screenUI.dart';
import 'package:maasapp/features/Register/views/screen/login.dart';
import 'package:maasapp/features/Register/views/screen/page.dart';
import 'package:maasapp/features/Register/views/screen/register.dart';
import 'package:maasapp/firebase_options.dart';

void main() async {
  Future.wait([ScreenUtil.ensureScreenSize()]).then((value) {
    runApp(  
    MaterialApp(
      title: 'A R A B N I',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 192, 208)),
        useMaterial3: true,
      ),
      home: const Login(),
      routes: {
        '/login/': (context) => const Login(),
        '/register/':(context) => const RegisterScreen(),
        '/page/':(context) => const Screen(),
      },
    ),
  );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //final user = (FirebaseAuth.instance.currentUser);
              //if (user != null) {
                //if (user.emailVerified) {
                 //return const Notes();
                //} else {
                  //return const Verify();
                //}
              //} else {
                //return const Login();
              //} 
              return const Login();  
          default:
            return const  CircularProgressIndicator();
          }
        },
      );    
  }
}
