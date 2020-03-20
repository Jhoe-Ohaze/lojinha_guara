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
          height: 450,
          child: CustomCalendar(DateTime(2020,12,31)),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
