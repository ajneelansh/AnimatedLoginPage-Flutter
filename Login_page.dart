import 'package:animation/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color.fromRGBO(209, 28, 121, 1.0),
        primaryColor: Color.fromRGBO(251, 177, 21, 1.0),
      ),
      home: LoginPage(),
    );
  }
}
