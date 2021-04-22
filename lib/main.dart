import 'package:flutter/material.dart';
import 'package:todo_application/screens/login_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Management App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: LoginScreen(),
    );
  }
}
