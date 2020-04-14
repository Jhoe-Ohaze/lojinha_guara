import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatefulWidget
{
  final Function _function;
  final IconData _iconData;
  final String _text;
  final int _side;

  HomeButtons(this._function, this._iconData, this._text, this._side);

  @override
  _HomeButtonsState createState() => _HomeButtonsState(_function, _iconData, _text, _side);
}

class _HomeButtonsState extends State<HomeButtons>
{
  final Function _function;
  final IconData _iconData;
  final String _text;
  final int _side;

  _HomeButtonsState(this._function, this._iconData, this._text, this._side);

  @override
  Widget build(BuildContext context)
  {
    if(_side == 1)
    {
      return MaterialButton
      (
        onPressed: _function,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
        child: Container
        (
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width/2 -39.5,
          child: Column
            (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Icon(_iconData, color: Colors.blue, size: 40),
              Container
                (
                padding: EdgeInsets.only(top: 5),
                child: Text(_text, style: TextStyle(fontFamily: 'Fredoka', fontSize: 12, color: Colors.grey[700]),),
              )
            ],
          ),
        ),
      );
    }

    else
      {
        return MaterialButton
        (
          onPressed: _function,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
          child: Container
            (
            padding: EdgeInsets.symmetric( vertical: 15),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/2 -39.5,
            child: Column
              (
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Icon(_iconData, color: Colors.blue, size: 40),
                Container
                  (
                  padding: EdgeInsets.only(top: 5),
                  child: Text(_text, style: TextStyle(fontFamily: 'Fredoka', fontSize: 12, color: Colors.grey[700]),),
                )
              ],
            ),
          ),
        );
      }
  }
}
