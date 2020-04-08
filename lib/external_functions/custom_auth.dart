import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomLogIn
{
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> getUser() async
  {
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

      final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(authCredential)).user;
      return user;
    }

    catch(error){return null;}
  }

  static void logOut()
  {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
  }
}