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
          Text("Entre ou Registre-se", style: TextStyle(fontSize: 15),),
          Expanded(child: Container(),),
          Icon(Icons.chevron_right, color: Colors.blueAccent)
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context)
  {
    return Material
    (
      color: Colors.transparent,
      child: InkWell
      (
        onTap: () async
        {
          Navigator.of(context).pop();
          _showLoading();
          _setUser();
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
          child: loginButton()
        ),
      ),
    );
  }
}
