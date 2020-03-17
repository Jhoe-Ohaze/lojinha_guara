import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget
{
  final IconData icon;
  final String text;
  final PageController pageController;
  final TextEditingController titleController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page, this.titleController);

  final blue = Color(0xFF0055FF);
  final cyan = Color(0x6633CCFF);

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
          titleController.text = text;
          pageController.jumpToPage(page);
        },
        child: Container
        (
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          
          decoration: BoxDecoration
          (
            color: pageController.page.round() == page ? cyan:Colors.transparent,
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
                color: pageController.page.round() == page ? blue : Colors.grey[700],
              ),
              SizedBox(width: 15.0),
              Text
              (
                text,
                style: TextStyle
                (
                  fontSize: 16.0,
                  color: pageController.page.round() == page ? blue : Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
