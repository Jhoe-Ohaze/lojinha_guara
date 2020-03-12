import 'package:flutter/material.dart';
import 'package:lojinha_guara/tabs/excursion_tab.dart';
import 'package:lojinha_guara/tabs/ticket_tab.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget
{
  final _pageController = PageController();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(title: TextField
      (
        readOnly: true,
        textAlign: TextAlign.center,
        controller: _titleController,
        decoration: InputDecoration
        (
            border: InputBorder.none
        ),
      )),
      drawer: CustomDrawer(_pageController, _titleController),
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
