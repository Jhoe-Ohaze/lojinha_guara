import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget
{
  final IconData icon;
  final String text;
  final Function function;

  CustomTile(this.icon, this.text, this.function);

  final blue = Color(0xFF2277DD);
  final cyan = Color(0x4466CCEE);

  @override
  Widget build(BuildContext context)
  {
    return Material
    (
      color: Colors.transparent,
      child: InkWell
      (
        onTap: function,
        child: Container
        (
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),

          height: 40.0,
          child: Row
          (
            children: <Widget>
            [
              Icon
              (
                icon,
                size: 25.0,
                color: Colors.grey[600],
              ),
              SizedBox(width: 15.0),
              Text
              (
                text,
                style: TextStyle
                (
                  fontSize: 16.0,
                  color: Colors.grey[600]
                ),
              ),
              Expanded(child: Container()),
              Icon(Icons.chevron_right, size: 20, color: Colors.grey[600],)
            ],
          ),
        ),
      ),
    );
  }
}
