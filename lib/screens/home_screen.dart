import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/excursion_screen.dart';
import 'package:lojinha_guara/screens/findus_screen.dart';
import 'package:lojinha_guara/screens/society_screen.dart';
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

    Widget _buildAppBar()
    {
      return SizedBox
      (
        height: MediaQuery.of(context).size.height*0.15,
        child: Stack
          (
          alignment: Alignment.topLeft,
          children: <Widget>
          [
            Image.asset('my_assets/images/menu.png', width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
            Container
              (
              margin: EdgeInsets.only(top: 7.5),
              child: Row
                (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                  Container
                    (
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: TextField
                      (
                      controller: _titleController,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, letterSpacing: 2, color: Colors.white, fontFamily: 'Fredoka'),
                      decoration: InputDecoration(border: InputBorder.none),
                      enableInteractiveSelection: false,
                      readOnly: true,
                    ),
                  )
                ],
              ),
            ),
            Container
            (
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: MaterialButton
              (
                highlightColor: Color(0x33FFFFFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                height: MediaQuery.of(context).size.height*0.065,
                minWidth:  MediaQuery.of(context).size.height*0.065,
                child: Icon(Icons.menu, color: Colors.white, size: 35,),
                onPressed: (){_scaffoldKey.currentState.openDrawer();},
              ),
            ),

          ],
        ),
      );
    }

    Widget _buildBody()
    {
      return Expanded
      (
        child: PageView
        (
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>
          [
            HomeTab(),
            TicketTab(_pageController, _titleController),
            ExcursionScreen(),
            SocietyScreen(),
            FindUsScreen(),
            Container(color: Colors.green)
          ],
        ),
      );
    }

    return Scaffold
    (
      key: _scaffoldKey,
      drawer: CustomDrawer(_pageController, _titleController),
      body: Column
      (
        children: <Widget>
        [
          _buildAppBar(),
          _buildBody(),
        ],
      )
    );
  }
}
