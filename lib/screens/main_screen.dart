import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lojinha_guara/screens/signin_screen.dart';
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
  FirebaseUser _currentUser;

  bool isLogged = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _currentWidget;
  int _currentPage = 0;

  void _logOut()
  {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    setState(() => _currentUser = null);
  }

  @override
  void initState()
  {
    super.initState();
    _currentWidget = HomeTab(setCurrentWidget);
    FirebaseAuth.instance.onAuthStateChanged.listen((user)
    {
      _currentUser = user;
      user == null ? isLogged = false : isLogged = true;
    });
    if(!isLogged) _logOut();
  }

  int _getPage() {return _currentPage;}

  Future<FirebaseUser> getUser() async
  {
    if(_currentUser != null) return _currentUser;
    final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

    final AuthCredential authCredential  = GoogleAuthProvider.getCredential
      (
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    final AuthResult authResult =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    final FirebaseUser user = authResult.user;
    return user;
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
    void _showLoading()
    {
      showDialog
        (
          context: context,
          builder: (context)
          {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            return Container
              (
                color: Colors.black26,
                width: width,
                height: height,
                alignment: Alignment.center,
                child: SizedBox
                  (
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                )
            );
          }
      );
    }

    void _setUser() async
    {
      _showLoading();
      try
      {
        final FirebaseUser user = await getUser();
        setState(() => _currentUser = user);

        final String uid = _currentUser.uid;
        CollectionReference colRef = Firestore.instance.collection('users');
        QuerySnapshot querySnapshot = await colRef.where('uid', isEqualTo: uid).getDocuments();
        Navigator.of(context).pop();
        if(querySnapshot.documents.length == 0) Navigator.of(context).push
          (MaterialPageRoute(builder: (context) => SignInScreen(_logOut)));
      }
      catch(e)
      {
        Navigator.of(context).pop();
        _logOut();
        _scaffoldKey.currentState.hideCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Não foi possível logar")));
      }
    }

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
      drawer: CustomDrawer(setCurrentWidget, _getPage, _setUser, _logOut, _currentUser),
      body: _buildBody(),
    );
  }

}
