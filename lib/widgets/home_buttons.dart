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
      return Container
      (
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width/2 -7.5,
        decoration: BoxDecoration
        (
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
        ),
        child: GestureDetector
        (
          onTap: _function,
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
        return Container
          (
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width/2 -7.5,
          decoration: BoxDecoration
          (
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          ),
          child: GestureDetector
          (
            onTap: _function,
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
