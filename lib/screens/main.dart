import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maasapp/screens/firebase_options.dart';
import 'package:maasapp/screens/login.dart';
import 'package:maasapp/screens/page.dart';
import 'package:maasapp/screens/register.dart';

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
        '/register/': (context) => const HomePage(),
        '/screen/': (context) => const Screen(),
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
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP UI'),
      ),
    );
  }
}
