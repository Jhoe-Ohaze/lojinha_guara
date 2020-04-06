import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/society_screen.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';

class SocietyTab extends StatelessWidget
{
  final id = 3;

  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      children: <Widget>
      [
        CustomBar("Sociedade"),
        Container
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.85,
          child: SocietyScreen(),
        ),
      ],
    );
  }
}
