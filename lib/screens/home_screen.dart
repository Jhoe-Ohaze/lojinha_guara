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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    _titleController.text = "Início";
    return Stack
    (
      key: _scaffoldKey,
      children: <Widget>
      [
        Scaffold
          (
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
              Container(color: Colors.red),
              Container(color: Colors.yellow),
              Container(color: Colors.green)
            ],
          ),
        ),
        SizedBox
        (
          height: MediaQuery.of(context).size.height*0.20,
          child: Stack
          (
            children: <Widget>
            [
              Image.asset('my_assets/menu.png', width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
              Row
              (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                  Container
                  (
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector
                      (
                      child: Icon(Icons.menu, color: Colors.white, size: 30,),
                      onTap: (){_scaffoldKey.currentState.openDrawer();},
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
