// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('A R A B N I'),
          leading: IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.menu),

          ),
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}