import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maasapp/core/utils/string_constants.dart';
import 'package:maasapp/features/Register/views/screen/login.dart';
//import 'package:maasapp/features/Register/views/screen/registerr.dart';
//import 'package:maasapp/features/Register/views/screen/forgetPass.dart';
//import 'package:maasapp/features/Register/views/screen/Home.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringConstants.appName,
          home: RegisterScreen(),
        );
      },
    );
  }
}
