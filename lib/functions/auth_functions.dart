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

  FirebaseUser currentUser;
  Map<String, dynamic> userData;

  String _uid;
  CollectionReference _colRef;
  QuerySnapshot _qrySnap;

  Future<void> initVariables() async
  {
    currentUser = await FirebaseAuth.instance.currentUser();
    if(currentUser != null)
    {
      _uid = currentUser.uid;
      _colRef = Firestore.instance.collection('users');
      _qrySnap = await _colRef.where('uid', isEqualTo: _uid).getDocuments();
      userData = _qrySnap.documents.elementAt(0).data;
      checkData();
    }
    else
    {
      userData = {};
    }
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
    currentUser = null;
  }

  void checkData()
  {
    if(userData == {}) logOut();
    else
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

  Future<void> logIn() async
  {
    try
    {
      userData = _qrySnap.documents.elementAt(0).data;
      checkData();
    }
    catch(e) {}
  }

  Future<void> updateData(int option) async
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

  Future<void> initLogin() async
  {
    try
    {
      if(currentUser != null)
      {
        final String uid = currentUser.uid;
        CollectionReference colRef = Firestore.instance.collection('users');
        QuerySnapshot querySnapshot = await colRef.where('uid', isEqualTo: uid).getDocuments();
        if(querySnapshot.documents.length != 0) await logIn();
      }
    }
    catch(e)
    {
      logOut();
    }
  }

  Future<void> setUser() async
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
      else await logIn();
    }
    catch(e)
    {
      Navigator.of(context).pop();
      logOut();
    }
  }
}