import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojinha_guara/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp
    (
      title: 'Flutter Demo',
      theme: ThemeData
      (
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
