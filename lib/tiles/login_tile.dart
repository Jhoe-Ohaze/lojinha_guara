import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInTile extends StatefulWidget
{
  FirebaseUser user;
  final Function _setUser;
  LogInTile(this._setUser, this.user);

  @override
  _LogInTileState createState() => _LogInTileState(_setUser, user);
}

class _LogInTileState extends State<LogInTile>
{
  final FirebaseUser user;
  final Function _setUser;
  _LogInTileState(this._setUser, this.user);

  Widget _currentWidget;

  @override
  void initState()
  {
    super.initState();
    _currentWidget = user == null ? loginButton():userProfile();
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
        onTap: (){setState(() {_setUser();});},
      ),
    );
  }

  Widget userProfile()
  {
    return Container();
  }

  @override
  Widget build(BuildContext context)
  {
    _currentWidget = user == null ? loginButton():userProfile();
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
