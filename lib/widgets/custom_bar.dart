import 'package:flutter/material.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';

class CustomBar extends StatelessWidget
{
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
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: ImageAssets.logoBar
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
