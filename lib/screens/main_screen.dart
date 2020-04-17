import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lojinha_guara/screens/signin_screen.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/widgets/custom_drawer.dart';


class MainScreen extends StatefulWidget
{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _currentUser;
  Map<String, dynamic> _userData;
  Widget _currentWidget;
  int _currentPage = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _uid;
  CollectionReference _colRef;
  QuerySnapshot _qrySnap;

  bool _isLoading = true;

  void _initVariables() async
  {
    _currentUser = await FirebaseAuth.instance.currentUser();
    _uid = _currentUser.uid;
    _colRef = Firestore.instance.collection('users');
    _qrySnap = await _colRef.where('uid', isEqualTo: _uid).getDocuments();
    _userData = _qrySnap.documents.elementAt(0).data;
    _checkData();
  }

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

  void _logOut()
  {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    setState(() => _currentUser = null);
  }

  void _logIn() async
  {
    _showLoading();
    try
    {
      setState(() => _userData = _qrySnap.documents.elementAt(0).data);
      _checkData();
      Navigator.of(context).pop();
    }
    catch(e)
    {
      Navigator.of(context).pop();
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Não foi possível efetuar Login")));
    }
  }

  void _checkData()
  {
    print(_currentUser);
    if(_currentUser != null && _userData == {}) _logOut();
    else if(_currentUser != null)
    {
      if(_currentUser.displayName != _userData['usuario'] || _currentUser.photoUrl != _userData['Foto'])
      {
        if (_currentUser.displayName != _userData['usuario'])
        {
          setState(()
          {
            _userData['usuario'] = _currentUser.displayName;
            updateData(1);
          });
        }
        if (_currentUser.photoUrl != _userData['Foto'])
        {
          setState(()
          {
            _userData['Foto'] = _currentUser.photoUrl;
            updateData(2);
          });
        }
      }
    }
    _isLoading = false;
  }

  void updateData(int option) async
  {
    String docId = _qrySnap.documents.elementAt(0).documentID;

    switch(option)
    {
      case 1:
        await Firestore.instance.collection('users').document(docId).updateData({'usuario':_currentUser.displayName});
        break;
      case 2:
        await Firestore.instance.collection('users').document(docId).updateData({'Foto':_currentUser.photoUrl});
        break;
      default: break;
    }
  }

  @override
  void initState()
  {
    super.initState();
    _currentWidget = HomeTab(setCurrentWidget);
    _initVariables();
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
          (MaterialPageRoute(builder: (context) => SignInScreen(_logOut, _logIn)));
        else _logIn();
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
      drawer: CustomDrawer(setCurrentWidget, _getPage, _setUser, _logOut, _currentUser, _userData),
      body: _buildBody(),
    );
  }

}
