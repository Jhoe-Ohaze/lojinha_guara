import 'package:flutter/material.dart';
import 'package:lojinha_guara/widgets/custom_map.dart';

class FindUsScreen extends StatefulWidget
{
  @override
  _FindUsScreenState createState() => _FindUsScreenState();
}

class _FindUsScreenState extends State<FindUsScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>
      [
        SizedBox
        (
          height: MediaQuery.of(context).size.height*0.4,
          child: Container
            (
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration
                (
                border: Border.all(color: Colors.grey),
              ),
              child: CustomMap()
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
