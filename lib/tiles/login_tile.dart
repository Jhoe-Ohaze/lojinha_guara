import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/external_functions/custom_auth.dart';

class LogInTile extends StatefulWidget
{
  final Function _setCurrentUser;
  LogInTile(this._setCurrentUser);

  @override
  _LogInTileState createState() => _LogInTileState(_setCurrentUser);
}

class _LogInTileState extends State<LogInTile>
{
  FirebaseUser user;
  Widget _currentWidget;
  final Function _setCurrentUser;
  _LogInTileState(this._setCurrentUser);

  @override
  void initState()
  {
    super.initState();
    _currentWidget = user == null ? loginButton():userProfile();
  }

  void LogIn() async
  {
    CustomLogIn login = CustomLogIn();
    user = await login.getUser();
    _setCurrentUser(user);
  }

  Widget loginButton()
  {
    return Scaffold
    (
      body: InkWell
      (
        child: Container
        (
          alignment: Alignment.centerLeft,
          child: Row
          (
            children: <Widget>
            [
              Text("Entre ou Registre-se"),
              Icon(Icons.chevron_right, color: Colors.grey[300])
            ],
          ),
        ),
        onTap: LogIn,
      ),
    );
  }

  Widget userProfile()
  {

  }

  @override
  Widget build(BuildContext context)
  {
    return Material
      (
      color: Colors.transparent,
      child: InkWell
        (
        onTap: ()
        {
          Navigator.of(context).pop();
        },
        child: Container
        (
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration
          (
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20)
          ),
          height: 40.0,
          child: _currentWidget
        ),
      ),
    );
  }
}
