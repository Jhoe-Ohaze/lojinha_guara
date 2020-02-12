import 'package:flutter/material.dart';
import 'package:lojinha/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return PageView
    (
      children: <Widget>
      [
        HomeTab(),
      ],
    );
  }
}
