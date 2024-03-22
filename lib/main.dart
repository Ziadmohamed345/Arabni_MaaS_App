import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maasapp/firebase_options.dart';
import 'package:maasapp/login.dart';
import 'package:maasapp/page.dart';
import 'package:maasapp/register.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 192, 208)),
        useMaterial3: true,
      ),
      home: const HOME(),
      routes: {
        '/login/': (context) => const Login(),
        '/register/':(context) => const HomePage(),
        '/screen/':(context) => const Screen(),
      },
    ),
  );
}

class HOME extends StatelessWidget {
  const HOME({super.key});

  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const Login();
          default:
            return const  CircularProgressIndicator();
          }
        },
          );    
  }
}



