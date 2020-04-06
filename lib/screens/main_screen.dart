import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';


class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
  final _titleController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _currentWidget = HomeTab();
  int _currentPage = 0;

  int _getPage()
  {
    return _currentPage;
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
    _titleController.text = "Início";

    Widget _buildBody()
    {
      return AnimatedSwitcher
      (
        duration: const Duration(seconds: 1),
        child: _currentWidget,
      );
    }

    return Scaffold
    (
      key: _scaffoldKey,
      drawer: CustomDrawer(_currentWidget, this._setCurrentWidget, this._getPage),
      body: _buildBody(),
    );
  }

}
