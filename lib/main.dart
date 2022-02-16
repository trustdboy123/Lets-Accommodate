import 'package:flutter/material.dart';

import 'auth/decision.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF322E2E),
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            centerTitle: true),
        primarySwatch: Colors.blue,
      ),
      home: Decision(),
    );
  }
}
