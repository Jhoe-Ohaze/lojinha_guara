import 'package:flutter/material.dart';
import 'package:lojinha_guara/widgets/custom_calendar.dart';

class CalendarScreen extends StatelessWidget
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
          height: MediaQuery.of(context).size.height/2,
          child: CustomCalendar(),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
