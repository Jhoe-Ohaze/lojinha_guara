import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/excursion_screen.dart';
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
    _titleController.text = "Início";
    return Scaffold
    (
      appBar: AppBar
      (
        title: Container
        (
          width: 200,
          alignment: Alignment.center,
          child: TextField
            (
            readOnly: true,
            style: TextStyle
              (
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            controller: _titleController,
            decoration: InputDecoration
            (
              border: InputBorder.none
            ),
          ),
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawer(_pageController, _titleController),
      body: PageView
      (
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>
        [
          HomeTab(),
          TicketTab(_pageController, _titleController),
          ExcursionScreen(),
        ],
      ),
    );
  }
}
