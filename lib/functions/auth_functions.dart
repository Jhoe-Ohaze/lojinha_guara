import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFunctions
{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<void> signInWithGoogle() async
  {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  static void signOutGoogle() async
  {
    await googleSignIn.signOut();
  }

  static Future<int> logInWithGoogle() async
  {
    final FirebaseUser _currentUser = await _auth.currentUser();
    if(_currentUser != null)
    {
      final String uid = _currentUser.uid;
      CollectionReference colRef = Firestore.instance.collection('users');
      QuerySnapshot querySnapshot = await colRef.where('uid', isEqualTo: uid).getDocuments();
      if(querySnapshot.documents.length == 0) return 1;
      else return 2;
    }
    return 0;
  }
}