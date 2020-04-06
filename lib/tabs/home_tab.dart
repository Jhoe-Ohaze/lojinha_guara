import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';
import 'package:lojinha_guara/widgets/custom_calendar.dart';

class HomeTab extends StatelessWidget
{
  final id = 0;

  @override
  Widget build(BuildContext context)
  {
    return _tabBody(context);
  }

  //////////////////////////////////////////////////////////////////////////////
  ////* Main Widget *///////////////////////////////////////////////////////////
  Widget _tabBody(context)
  {
    return Column
    (
      children: <Widget>
      [
        CustomBar("Início"),
        SingleChildScrollView
          (
          physics: BouncingScrollPhysics(),
          child: Column
            (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              //////////////////////////////////////////////////////////////////////
              ////* Calendar *//////////////////////////////////////////////////////
              SizedBox
              (
                height: 450,
                child: CustomCalendar(DateTime(2020, 12, 31)),
              ),
              //////////////////////////////////////////////////////////////////////
              //////////////////////////////////////////////////////////////////////

            ],
          ),
        )
      ],
    );
  }
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
}