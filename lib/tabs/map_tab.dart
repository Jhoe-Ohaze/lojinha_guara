import 'package:flutter/material.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';
import 'package:lojinha_guara/widgets/custom_map.dart';

class MapTab extends StatelessWidget
{
  final id = 4;

  @override
  Widget build(BuildContext context)
  {
    return Stack
    (
      alignment: Alignment.topLeft,
      children: <Widget>
      [
        SizedBox
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomMap(),
        ),
        CustomBar("Encontre-nos"),
      ],
    );
  }
}
