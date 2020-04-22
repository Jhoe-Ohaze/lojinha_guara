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
  AuthFunctions auth;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _currentWidget;
  int _currentPage = 0;

  @override
  void initState()
  {
    super.initState();
    auth = AuthFunctions(context, _scaffoldKey);
    _currentWidget = HomeTab(setCurrentWidget);
    auth.initVariables();
  }

  int _getPage() {return _currentPage;}

  void setCurrentWidget(id, widget)
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
      key: _scaffoldKey,
      drawer: CustomDrawer(setCurrentWidget, _getPage, auth.setUser, auth.logOut, auth.currentUser, auth.userData),
      body: _buildBody(),
    );
  }

}
