import 'package:flutter/material.dart';

class LogInTile extends StatefulWidget
{
  final Function _setUser;
  LogInTile(this._setUser);

  @override
  _LogInTileState createState() => _LogInTileState(_setUser);
}

class _LogInTileState extends State<LogInTile>
{
  final Function _setUser;
  _LogInTileState(this._setUser);

  Widget loginButton()
  {
    return Container
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
    );
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
          _setUser();
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
          child: loginButton()
        ),
      ),
    );
  }
}
