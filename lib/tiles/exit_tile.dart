import 'package:flutter/material.dart';
import 'package:lojinha_guara/external_functions/custom_auth.dart';

class ExitTile extends StatelessWidget
{
  final IconData icon = Icons.exit_to_app;
  final String text = "Sair";

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
          CustomLogIn.logOut();
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
          child: Row
            (
            children: <Widget>
            [
              Icon
                (
                icon,
                size: 25.0,
                color: Colors.grey[700],
              ),
              SizedBox(width: 15.0),
              Text
              (
                text,
                style: TextStyle
                (
                    fontSize: 16.0,
                    color: Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
