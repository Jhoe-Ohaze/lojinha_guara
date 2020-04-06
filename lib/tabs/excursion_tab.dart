import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/excursion_screen.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';

class ExcursionTab extends StatelessWidget
{
  final id = 2;
  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>
      [
        CustomBar("Excursões"),
        Container
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.85,
          child: ExcursionScreen(),
        ),
      ],
    );
  }
}
