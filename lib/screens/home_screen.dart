import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/product_screen.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget
{
  final _pageController = PageController();

  @override
  Widget build(BuildContext context)
  {
    return PageView
    (
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>
      [
        Scaffold
        (
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold
        (
          body: ProductScreen(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold
        (
          body: Container(color: Colors.blue,),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold
        (
          body: Container(color: Colors.green,),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
