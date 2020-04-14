import 'package:flutter/material.dart';

class CustomFeed extends StatelessWidget
{
  final Image image;
  final String title;
  final String text;
  final String buttonText;
  final Function buttonFunction;

  CustomFeed(this.image, this.title, this.text, this.buttonText, this.buttonFunction);

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      decoration: BoxDecoration
      (
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
          SizedBox
          (
            height: 150,
            child: ClipRRect
              (
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: image,
            ),
          ),
          Container
          (
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                Container
                 (
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(title, style: TextStyle(fontSize: 25, fontFamily: 'Fredoka')),
                ),
                Text(text, style: TextStyle(fontFamily: 'Fredoka', color: Colors.grey[600])),
                Container
                (
                  margin: EdgeInsets.only(top: 20, bottom: 5),
                  alignment: Alignment.centerRight,
                  child: MaterialButton
                  (
                    shape: RoundedRectangleBorder(side: BorderSide
                      (color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(buttonText, style: TextStyle
                      (fontFamily: 'Fredoka', color: Colors.blue), textAlign: TextAlign.justify),
                    onPressed: buttonFunction,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
