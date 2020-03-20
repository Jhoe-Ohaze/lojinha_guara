import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class CustomCalendar extends StatefulWidget
{
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar>
{
  int weekday;
  double _screenWidth;
  DateTime _currentDate;
  DateTime _selectedDate;
  TextEditingController _dateController;
  String dropdownValue = "Aniversário";

  @override
  void initState()
  {
    super.initState();

    _currentDate = DateTime.now().weekday == 2 ? DateTime.now().add(Duration(days: 8)) : DateTime.now().add(Duration(days: 7));
    _selectedDate = _currentDate;

    weekday = _currentDate.weekday;

    String initDate = DateFormat('dd/MM/yyyy').format(_currentDate).toString();

    _dateController = new TextEditingController(text: initDate);
  }

  Widget CalendarBuilder()
  {
    EventList<Event> _markedDateMap = new EventList<Event>
    (
      events:
      {

      }
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _selectedDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
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
        ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          if (day.weekday == 2) {
            return Container();
          } else {
            return null;
          }
        },
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _selectedDate,
        daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return CalendarBuilder();
  }
}
