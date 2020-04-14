import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/main_screen.dart';

class DrawerTile extends StatelessWidget
{
  final IconData icon;
  final String text;
  final int page;
  final Widget _targetWidget;
  final Function _setWidget;
  final Function _currentPage;


  DrawerTile(this.icon, this.text, this._targetWidget, this._setWidget, this._currentPage, this.page);

  final blue = Color(0xFF0055FF);
  final cyan = Color(0x6633CCFF);

  @override
  Widget build(BuildContext context)
  {
    final pageID = _currentPage();
    return Material
    (
      color: Colors.transparent,
      child: InkWell
      (
        onTap: ()
        {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.of(context).pop();
          _setWidget(page, Container());
          _setWidget(page, _targetWidget);
        },
        child: Container
        (
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          
          decoration: BoxDecoration
          (
            color: pageID == page ? cyan:Colors.transparent,
            borderRadius: BorderRadius.circular(20)
          ),
          height: 40.0,
          child: Row
          (
            children: <Widget>
            [
              Icon
              (
                icon,
                size: 25.0,
                color: pageID == page ? blue : Colors.grey[700],
              ),
              SizedBox(width: 15.0),
              Text
              (
                text,
                style: TextStyle
                (
                  fontSize: 16.0,
                  color: _currentPage == page ? blue : Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
