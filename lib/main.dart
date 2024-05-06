import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maasapp/core/utils/string_constants.dart';
import 'package:maasapp/features/Iternairy/view models/screenUI.dart';

void main() async {
  Future.wait([ScreenUtil.ensureScreenSize()]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringConstants.appName,
          home: LocationScreen(),
        );
      },
    );
  }
}
