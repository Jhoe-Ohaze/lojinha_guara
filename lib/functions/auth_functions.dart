import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lojinha_guara/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class AuthFunctions
{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final BuildContext context;
  AuthFunctions(this.context);

  FirebaseUser _currentUser;
  Map<String, dynamic> userData;

  String _uid;
  CollectionReference _colRef;
  QuerySnapshot _qrySnap;

  void initVariables() async
  {
    _currentUser = await FirebaseAuth.instance.currentUser();
    _uid = _currentUser.uid;
    _colRef = Firestore.instance.collection('users');
    _qrySnap = await _colRef.where('uid', isEqualTo: _uid).getDocuments();
    userData = _qrySnap.documents.elementAt(0).data;
    checkData();
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

  void logOut()
  {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    _currentUser = null;
  }

  void checkData()
  {
    print(_currentUser);
    if(_currentUser != null && userData == {}) logOut();
    else if(_currentUser != null)
    {
      if(_currentUser.displayName != userData['usuario'] || _currentUser.photoUrl != userData['Foto'])
      {
        if (_currentUser.displayName != userData['usuario'])
        {
          userData['usuario'] = _currentUser.displayName;
          updateData(1);
        }
        if (_currentUser.photoUrl != userData['Foto'])
        {
          userData['Foto'] = _currentUser.photoUrl;
          updateData(2);
        }
      }
    }
  }

  void logIn() async
  {
    _showLoading();
    try
    {
      userData = _qrySnap.documents.elementAt(0).data;
      checkData();
      Navigator.of(context).pop();
    }
    catch(e)
    {
      Navigator.of(context).pop();
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Não foi possível efetuar Login")));
    }
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

  void _setUser() async
  {
    _showLoading();
    try
    {
      final FirebaseUser user = await getUser();
      _currentUser = user;

      final String uid = _currentUser.uid;
      CollectionReference colRef = Firestore.instance.collection('users');
      QuerySnapshot querySnapshot = await colRef.where('uid', isEqualTo: uid).getDocuments();
      Navigator.of(context).pop();
      if(querySnapshot.documents.length == 0) Navigator.of(context).push
        (MaterialPageRoute(builder: (context) => SignInScreen(logOut, logIn)));
      else logIn();
    }
    catch(e)
    {
      Navigator.of(context).pop();
      logOut();
    }
  }
}