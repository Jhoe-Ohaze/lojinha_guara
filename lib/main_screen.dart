import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/functions/auth_functions.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
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
  FirebaseUser _currentUser;
  Map<String, dynamic> _userData;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState()
  {
    super.initState();
    _currentWidget = initLoading();
    auth = AuthFunctions(context);
    initVariables();
  }

  void initVariables() async
  {
    await auth.initVariables();
    _currentUser = auth.currentUser;
    await _initLogin();
  }

  void setCurrentWidget(id, widget)
  {
    setState(()
    {
      _currentPage = id;
      _currentWidget = widget;
    });
  }

  Widget _buildBody()
  {
    return Scaffold
      (
      key: _scaffoldKey,
      drawer: CustomDrawer(setCurrentWidget, _getPage, _setUser, _logOut, _currentUser, _userData),
      body: AnimatedSwitcher
      (
        duration: Duration(milliseconds: 500),
        child: _currentWidget,
      ),
    );
  }

  Widget initLoading()
  {
    return Container
      (
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Column
        (
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>
        [
          SizedBox(height: 100,),
          ImageAssets.loadingImage,
          SizedBox(height: MediaQuery.of(context).size.height/2 -200),
          CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
        ],
      ),
    );
  }

  void _setUser() async
  {
    try
    {
      await auth.setUser();
      _validate();
    }
    catch(e)
    {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Falha ao tentar logar")));
    }
  }

  void _logOut()
  {
    auth.logOut();
    _validate();
  }

  Future<void> _initLogin() async
  {
    await auth.initLogin();
    _userData = auth.userData;
    _currentUser = auth.currentUser;
    setState(()
    {
      _currentWidget = HomeTab(setCurrentWidget);
    });
  }

  void _validate()
  {
    setState(()
    {
      _userData = auth.userData;
      _currentUser = auth.currentUser;
    });
  }

  int _getPage() {return _currentPage;}

  @override
  Widget build(BuildContext context)
  {
    return _buildBody();
  }

}
