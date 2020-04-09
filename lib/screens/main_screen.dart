import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';


class MainScreen extends StatefulWidget
{
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _user;

  Widget _currentWidget;
  int _currentPage = 0;

  @override
  void initState()
  {
    super.initState();
    _currentWidget = HomeTab(setCurrentWidget);
    FirebaseAuth.instance.onAuthStateChanged.listen((user)
    {
      _user = user;
    });
  }

  int _getPage()
  {
    return _currentPage;
  }

  Future<FirebaseUser> getUser() async
  {
    if(_user != null) return _user;
    try
    {
      final GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential
        (
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );

      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(authCredential);
      final FirebaseUser user = authResult.user;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("OK"),));
      return user;
    }

    catch(error){return null;}
  }

  void _logOut()
  {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
  }

  void _setUser() async
  {
    final FirebaseUser user = await getUser();
    setState(()
    {
      this._user = user;
    });
  }

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
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(setCurrentWidget, _getPage, _setUser, _logOut),
      body: _buildBody(),
    );
  }

}
