import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/functions/auth_functions.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/tabs/profile_tab.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';

class MainScreen extends StatefulWidget
{
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
  int _currentIndex = 0;
  static AuthFunctions authFunctions;
  FirebaseUser _currentUser;

  List<Widget> _widgetList = [HomeTab(), Container(), ProfileTab()];

  @override
  void initState()
  {
    super.initState();
    asyncInit();
  }

  void asyncInit() async
  {
    _currentUser = await FirebaseAuth.instance.currentUser();
    int option = await AuthFunctions.logInWithGoogle();
    option == 1 ? AuthFunctions.signOutGoogle():null;
  }

  void _onItemTapped(int index)
  {
    setState(() => _currentIndex = index);
  }

  Widget _buidBody()
  {
    return Scaffold
    (
      body: Stack
      (
        alignment: Alignment.topCenter,
        children: <Widget>
        [
          _widgetList.elementAt(_currentIndex),
          _currentIndex == _widgetList.length-1 ? Container():CustomBar()
        ],
      ),
      bottomNavigationBar: Container
      (
        decoration: BoxDecoration
        (
          border: Border(top: BorderSide(width: 1, color: Colors.grey[300]))
        ),
        child: BottomNavigationBar
          (
            elevation: 0,
            unselectedFontSize: 0,
            selectedFontSize: 0,
            iconSize: 30,
            items:
            [
              new BottomNavigationBarItem
              (
                icon: const Icon(Icons.home),
                title: new Text(''),
              ),

              new BottomNavigationBarItem
              (
                icon: const Icon(Icons.beach_access),
                title: new Text(''),
              ),

              new BottomNavigationBarItem
              (
                icon: const Icon(Icons.account_circle),
                title: new Text(''),
              )
            ],
            currentIndex: _currentIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context)
  {
    if(authFunctions == null) authFunctions = AuthFunctions();
    return _buidBody();
  }

}
