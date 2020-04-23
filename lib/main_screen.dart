import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/functions/auth_functions.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';


class MainScreen extends StatefulWidget
{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
  Widget _currentWidget;
  int _currentPage = 0;
  AuthFunctions auth;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState()
  {
    super.initState();
    _currentWidget = HomeTab(setCurrentWidget);
    auth = AuthFunctions(context);
    auth.initVariables();
  }

  void setCurrentWidget(id, widget)
  {
    setState(()
    {
      _currentPage = id;
      _currentWidget = widget;
    });
  }

  int _getPage() {return _currentPage;}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      key: _scaffoldKey,
      drawer: CustomDrawer(setCurrentWidget, _getPage, _setUser, _logOut, _currentUser, _userData),
      body: _currentWidget,
    );
  }

}
