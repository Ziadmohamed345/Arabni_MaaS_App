import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maasapp/features/Lines/BusLines/viewmodels/busRoutes.dart';
import 'package:maasapp/features/Lines/views/optionsbar.dart';
import 'package:maasapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A R A B N I',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 198, 192, 208),
        ),
        useMaterial3: true,
      ),
      home: BusLines(),
      routes: {
        '/busLines/': (context) => BusLines(),
        '/busRoutes/': (context) => BusRoutes(),
      },
    );
  }
}
