import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'Flutter Demo',
      theme: ThemeData
      (
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF0055FF),
        accentColor: Color(0x6633CCFF)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
