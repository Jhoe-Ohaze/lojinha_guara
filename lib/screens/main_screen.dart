import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';


class MainScreen extends StatefulWidget
{
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
  FirebaseUser user;
  Widget _currentWidget = HomeTab();
  int _currentPage = 0;

  int _getPage()
  {
    return _currentPage;
  }

  void _setCurrentUser(user)
  {
    setState(()
    {
      this.user = user;
    });
  }

  void _setCurrentWidget(id, widget)
  {
    setState(()
    {
      _currentPage = id;
      _currentWidget = widget;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    Widget _buildBody()
    {
      return AnimatedSwitcher
      (
        duration: const Duration(milliseconds: 500),
        child: _currentWidget,
      );
    }

    return Scaffold
    (
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(_setCurrentWidget, _getPage, _setCurrentUser),
      body: _buildBody(),
    );
  }

}
