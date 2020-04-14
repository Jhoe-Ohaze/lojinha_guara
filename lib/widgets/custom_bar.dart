import 'package:flutter/material.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';

class CustomBar extends StatelessWidget
{
  final _titleText;

  CustomBar(this._titleText);

  @override
  Widget build(BuildContext context)
  {
    return SizedBox
    (
      height: 120,
      child: Stack
        (
        alignment: Alignment.topLeft,
        children: <Widget>
        [
          ImageAssets.menuBlueImage(MediaQuery.of(context).size.width),
          Container
            (
            margin: EdgeInsets.only(top: 7.5),
            child: Row
              (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                Container
                (
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text
                  (
                    _titleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, letterSpacing: 2, color: Colors.white, fontFamily: 'Fredoka'),
                  )
                )
              ],
            ),
          ),
          Container
          (
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
            alignment: Alignment.centerLeft,
            child: MaterialButton
            (
              highlightColor: Color(0x33FFFFFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              height: MediaQuery.of(context).size.height*0.065,
              minWidth:  MediaQuery.of(context).size.height*0.065,
              child: Icon(Icons.menu, color: Colors.white, size: 35,),
              onPressed: (){Scaffold.of(context).openDrawer();},
            ),
          ),
        ],
      ),
    );
  }
}
