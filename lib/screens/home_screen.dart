import 'package:flutter/material.dart';
import 'package:lojinha_guara/tabs/excursion_tab.dart';
import 'package:lojinha_guara/tabs/ticket_tab.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget
{
  final _pageController = PageController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(),
      drawer: CustomDrawer(_pageController),
      body: PageView
      (
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>
        [
          HomeTab(),
          TicketTab(),
          ExcursionTab(),
        ],
      ),
    );
  }
}
