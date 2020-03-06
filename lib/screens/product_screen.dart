import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class ProductScreen extends StatefulWidget
{
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
{
  TextEditingController _adultController;
  TextEditingController _kidController;
  int itemAmount;
  int adultAmount;
  int kidAmount;
  DateTime _currentDate = DateTime.now();

  @override
  void initState()
  {
    super.initState();
    _adultController = new TextEditingController(text: adultAmount.toString());
    _kidController = new TextEditingController(text: kidAmount.toString());
  }

  Widget _buildAmountPicker(field, numberController, amount)
  {
    return Padding
      (
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: Container
        (
        decoration: BoxDecoration
          (
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row
          (
          children: <Widget>
          [
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(field, style: TextStyle(fontSize: 16))),
            Expanded(child: Container()),
            Row
              (
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>
              [
                IconButton
                  (
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  iconSize: 40,
                  icon: Icon(Icons.arrow_left, color: Colors.blue,),
                  onPressed: ()
                  {
                    setState(()
                    {
                      if(amount > 0)
                      {
                        amount--;
                        numberController.text = amount.toString();
                        print(amount);
                      }
                    });
                  },
                ),

                Container
                  (
                  width: 60,
                  child: TextField
                    (
                    readOnly: true,
                    cursorColor: Color(0x00ffffff),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: numberController,
                    decoration: InputDecoration
                      (
                        border: InputBorder.none
                    ),
                  ),
                ),

                IconButton
                  (
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  iconSize: 40,
                  icon: Icon(Icons.arrow_right, color: Colors.blue,),
                  onPressed: ()
                  {
                    setState(()
                    {
                      if(amount < 20)
                      {
                        amount++;
                        numberController.text = amount.toString();
                        print(amount);
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody()
  {
    return SingleChildScrollView
    (
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
          AppBar
            (
            title: Text
              (
              "Comprar Ingressos",
              style: TextStyle
                (
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),

          CalendarCarousel<Event>
          (
            onDayPressed: (date, events)
            {
              this.setState(()
              {
                if(date.weekday != 2) _currentDate = date;
              });
            },

            weekFormat: false,
            weekendTextStyle: TextStyle(color: Colors.red),
            thisMonthDayBorderColor: Colors.grey,
            height: MediaQuery.of(context).size.height/1.7,
            selectedDateTime: _currentDate,
            daysHaveCircularBorder: false,
            customDayBuilder: (bool isSelectable, int index, bool isSelectedDay,
                bool isToday, bool isPrevMonthDay, TextStyle textStyle,
                bool isNextMonthDay, bool isThisMonthDay, DateTime day,)
            {
              if(day.isBefore(_currentDate)){isSelectable = false;}
              if(day.weekday == 2){return Container();}
              else{return null;}
            },
          ),

          _buildAmountPicker("Adultos", _adultController, adultAmount),
          _buildAmountPicker("Crianças", _kidController, kidAmount),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildBody();
  }
}