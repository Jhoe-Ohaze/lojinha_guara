import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class CustomCalendar extends StatefulWidget
{
  final DateTime _maxDate;
  CustomCalendar(this._maxDate);

  @override
  _CustomCalendarState createState() => _CustomCalendarState(_maxDate);
}

class _CustomCalendarState extends State<CustomCalendar>
{
  int weekday;
  DateTime _currentDate;
  DateTime _selectedDate;
  String dropdownValue = "Aniversário";

  final DateTime _maxDate;
  _CustomCalendarState(this._maxDate);

  @override
  void initState()
  {
    super.initState();

    _currentDate = DateTime.now().weekday == 2 ? DateTime.now().add(Duration(days: 1)) : DateTime.now();
    _selectedDate = null;

    weekday = _currentDate.weekday;
  }

  Widget _calendarBuilder()
  {
    EventList<Event> _markedDateMap = new EventList<Event>
    (
      events:
      {

      }
    );

    void _showDialog(int option)
    {
      showDialog
        (
          context: context,
          builder: (context)
          {
            switch(option)
            {
              case 1: return AlertDialog
              (
                title: Text("Aviso", textAlign: TextAlign.center),
                content: Text("O Park estará fechado na data selecionada", textAlign: TextAlign.justify,),
                actions: <Widget>
                [
                  FlatButton
                    (
                    child: Text("ok"),
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ); break;

              case 2: return AlertDialog
                (
                title: Text("Aviso", textAlign: TextAlign.center,),
                content: Text("Selecione datas a partir de hoje", textAlign: TextAlign.justify),
                actions: <Widget>
                [
                  FlatButton
                    (
                    child: Text("ok"),
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ); break;

              default: return null;
            }
          }
      );
    }

    return Container
    (
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration
      (
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CalendarCarousel<Event>
      (
        markedDatesMap: _markedDateMap,
        height: 420.0,
        isScrollable: false,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        daysHaveCircularBorder: null,
        showOnlyCurrentMonthDate: true,

        selectedDateTime: _selectedDate,
        minSelectedDate: _currentDate.subtract(Duration(days: 1)),
        maxSelectedDate: _maxDate,

        weekendTextStyle: TextStyle(color: Colors.red),
        weekdayTextStyle: TextStyle(color: Colors.grey),

        selectedDayButtonColor: Colors.lightGreen[400],
        selectedDayTextStyle: TextStyle(color: Colors.white),
        selectedDayBorderColor: Colors.transparent,

        todayBorderColor: Colors.transparent,
        todayButtonColor: Colors.transparent,
        todayTextStyle: TextStyle(color: weekday == 0 || weekday == 6 ? Colors.red:Colors.black),

        leftButtonIcon: Icon(Icons.chevron_left, color: Colors.blue),
        rightButtonIcon: Icon(Icons.chevron_right, color: Colors.blue),
        headerTextStyle: TextStyle(color: Colors.black, fontSize: 20),

        customDayBuilder:
        (   /// you can provide your own build function to make custom day containers
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        )
        {
          if(day.isBefore(_currentDate.subtract(Duration(days: 1))))
          {
            return Container
            (
              alignment: Alignment.center,
              child: Text(day.day.toString(), style: TextStyle(color: Colors.grey[300])),
            );
          }
          else if (day.weekday == 2)
          {
            return Container
            (
              alignment: Alignment.center,
              child: Icon(Icons.close, color: Colors.grey[300], size: 20,),
            );
          }
          else
          {
            return null;
          }
        },

        onDayPressed: (DateTime date, List<Event> events)
        {
          if(date.isBefore(_currentDate.subtract(Duration(days: 1)))){_showDialog(2);}
          else if(date.weekday != 2){this.setState(() => _selectedDate = date);}
          else{_showDialog(1);}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _calendarBuilder();
  }
}
