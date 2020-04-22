import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lojinha_guara/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class AuthFunctions
{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser currentUser;
  Map<String, dynamic> userData;

  String _uid;
  CollectionReference _colRef;
  QuerySnapshot _qrySnap;

  final BuildContext context;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  AuthFunctions(this.context, this._scaffoldKey);

  void initVariables() async
  {
    currentUser = await FirebaseAuth.instance.currentUser();
    _uid = currentUser.uid;
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
    _googleSignIn.signOut();
    currentUser = null;
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
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Não foi possível efetuar LogIn")));
    }
  }

  void checkData()
  {
    print(currentUser);
    if(currentUser != null && userData == {}) logOut();
    else if(currentUser != null)
    {
      if(currentUser.displayName != userData['usuario'] || currentUser.photoUrl != userData['Foto'])
      {
        if (currentUser.displayName != userData['usuario'])
        {
          userData['usuario'] = currentUser.displayName;
          updateData(1);
        }
        if (currentUser.photoUrl != userData['Foto'])
        {
          userData['Foto'] = currentUser.photoUrl;
          updateData(2);
        }
      }
    }
  }

  void updateData(int option) async
  {
    String docId = _qrySnap.documents.elementAt(0).documentID;

    switch(option)
    {
      case 1:
        await Firestore.instance.collection('users').document(docId).updateData({'usuario':currentUser.displayName});
        break;
      case 2:
        await Firestore.instance.collection('users').document(docId).updateData({'Foto':currentUser.photoUrl});
        break;
      default: break;
    }
  }

  Future<FirebaseUser> getUser() async
  {
    if(currentUser != null) return currentUser;
    final GoogleSignInAccount googleSignInAccount =
    await _googleSignIn.signIn();
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

  void setUser() async
  {
    _showLoading();
    try
    {
      final FirebaseUser user = await getUser();
      currentUser = user;

      final String uid = currentUser.uid;
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
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Não foi possível efetuar LogIn")));
    }
  }

}