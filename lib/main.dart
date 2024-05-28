import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maasapp/features/Lines/BusLines/viewmodels/busRoutes.dart';
import 'package:maasapp/features/Lines/views/optionsbar.dart';
import 'package:maasapp/features/Lines/BusLines/viewmodels/lines.dart';
import 'package:maasapp/features/Profile/views/screen/profileScreen.dart';
import 'package:maasapp/features/Profile/views/screen/manageAccount.dart'
    as manageAccount;
import 'package:maasapp/features/Profile/views/screen/feedback.dart'
    as feedback;
import 'package:maasapp/features/Profile/views/screen/helpCenter.dart'
    as helpCenter;
import 'package:maasapp/features/Register/views/screen/login.dart';
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
      home: ProfileScreen(), // Set ProfileScreen as the home screen
      routes: {
        '/busLines/': (context) => OptionsBar(),
        '/busRoutes/': (context) => BusRoutes(),
        '/linesScreen/': (context) => LinesScreen(),
        '/manageAccount/': (context) => manageAccount.ManageAccountScreen(),
        '/feedback/': (context) => feedback.FeedbackScreen(),
        '/helpCenter/': (context) => helpCenter.HelpCenterScreen(),
        '/login/': (context) => Login(),
      },
    );
  }
}
