import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget
{
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

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
          pageController.animateToPage(page, curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
        },
        child: Container
        (
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration
          (
            color: pageController.page.round() == page ? Theme.of(context).accentColor:Colors.transparent,
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
                color: pageController.page.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 15.0),
              Text
              (
                text,
                style: TextStyle
                (
                  fontSize: 16.0,
                  color: pageController.page.round() == page ? Theme.of(context).primaryColor : Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
