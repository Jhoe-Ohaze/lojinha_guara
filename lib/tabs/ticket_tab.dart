import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketTab extends StatefulWidget
{
  @override
  final PageController pageController;
  final TextEditingController titleController;

  TicketTab(this.pageController, this.titleController);

  _TicketTabState createState() => _TicketTabState(pageController, titleController);
}

class _TicketTabState extends State<TicketTab>
{
  final PageController pageController;
  final TextEditingController titleController;

  _TicketTabState(this.pageController, this.titleController);

  TextEditingController _adultController;
  TextEditingController _kidController;
  TextEditingController _dateController;
  TextEditingController _valueController;

  int itemAmount = 0;
  int adultAmount = 0;
  int kidAmount = 0;

  DateTime _currentDate;
  DateTime _selectedDate;

  double adultPrice = 0.00;
  double kidPrice = 0.00;
  double totalPrice = 0.00;

  int weekday = 0;

  @override
  void initState()
  {
    super.initState();
    _adultController = new TextEditingController(text: adultAmount.toString());
    _kidController = new TextEditingController(text: kidAmount.toString());

    _currentDate = DateTime.now().weekday == 2 ? DateTime.now().add(Duration(days: 1)) : DateTime.now();
    _selectedDate = _currentDate;
    String initDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    _dateController = new TextEditingController(text: initDate);
    _valueController = new TextEditingController(text: "0.00");
  }

  void _showDialog(int option)
  {
    showDialog
    (
      context: context,
      builder: (context)
      {
        switch(option)
        {
          case 0:
            double _imageWidth = MediaQuery.of(context).size.width - 80;
            double _imageHeight = (5/3) * _imageWidth;
            Image _imageExcursion = Image.asset
            (
              'my_assets/evento.jpeg',
              width: _imageWidth,
              height: _imageHeight,
            );

            return Container
            (
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Stack
              (
                children: <Widget>
                [
                  GestureDetector
                  (
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      titleController.text = "Excursões";
                      pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    child: _imageExcursion,
                  ),
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>
                    [
                      GestureDetector
                      (
                        child: Container(padding: EdgeInsets.all(5), child: Icon(Icons.close, size: 30, color: Color(0x88000000)),),
                        onTap: ()
                        {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ); break;

          case 1: return AlertDialog
          (
            title: Text("Aviso", textAlign: TextAlign.center,),
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

          default: return null;
        }
      }
    );
  }

  Widget _buildAmountPicker(field, numberController, isAdult)
  {
    int amount = isAdult ? adultAmount : kidAmount;
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
                        isAdult ? adultAmount-- : kidAmount--;
                        numberController.text = amount.toString();
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
                      if(itemAmount < 20)
                      {
                        amount++;
                        isAdult ? adultAmount++ : kidAmount++;
                        numberController.text = amount.toString();
                      }
                      else
                      {
                        _showDialog(0);
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

  Widget _buildDatePicker()
  {
    String initDate = DateFormat('dd/MM/yyyy').format(_selectedDate).toString();
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
                child: Text("Data", style: TextStyle(fontSize: 16))),
            Expanded(child: Container()),
            Row
              (
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>
              [
                Container
                (
                  width: 90,
                  child: TextField
                  (
                    readOnly: true,
                    cursorColor: Color(0x00ffffff),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _dateController,
                    decoration: InputDecoration
                    (
                        border: InputBorder.none
                    ),
                  ),
                ),

                IconButton
                (
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  iconSize: 20,
                  icon: Icon(Icons.calendar_today, color: Colors.blue,),
                  onPressed: () async
                  {
                    DateTime selectedDate = await showDatePicker
                    (
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: _currentDate.subtract(Duration(days: 1)),
                      lastDate: DateTime(2020, 12, 31),
                      builder: (context, child)
                      {
                        return Theme
                        (
                          data: ThemeData.light(),
                          child: child,
                        );
                      }
                    );

                    if(selectedDate != null)
                    {
                      setState(()
                      {
                        int auxWeekday = weekday;
                        weekday = selectedDate.weekday;
                        if(weekday != 2)
                        {
                          _selectedDate = selectedDate;
                          initDate = DateFormat('dd/MM/yyyy').format(_selectedDate).toString();
                          _dateController.text = initDate;
                        }
                        else
                        {
                          weekday = auxWeekday;
                          _showDialog(1);
                        }
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriceAndButton()
  {
    return Padding
      (
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
        child: Row
          (
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>
          [
            Container
              (
              decoration: BoxDecoration
                (
                border: Border.all(color: Colors.redAccent, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row
                (
                children: <Widget>
                [
                  Container
                    (
                    padding: EdgeInsets.only(left: 10),
                    child: Text("R\$", style: TextStyle(fontSize: 16),),
                  ),
                  Container
                    (
                    padding: EdgeInsets.only(right: 10),
                    width: 90,
                    child: TextField
                      (
                      readOnly: true,
                      cursorColor: Color(0x00ffffff),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: _valueController,
                      decoration: InputDecoration
                        (
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            ),

            Expanded
              (
                child: Container
                  (
                  decoration: BoxDecoration
                    (
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.redAccent
                  ),
                  margin: EdgeInsets.only(left: 5),
                  child :InkWell
                    (
                    child: TextField
                      (
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration
                        (
                          hintText: "Finalizar Compra",
                          hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                )
            )
          ],
        )
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
          _postFunctions(),
          Container
          (
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration
            (
              border: Border.all(width: 2, color: Colors.grey[700]),
              borderRadius: BorderRadius.circular(8)
            ),
            child: ClipRRect
            (

              borderRadius: BorderRadius.circular(5),
              child: Image.asset('my_assets/foto_pulseirinha.jpg'),
            ),
          ),

          Container
          (
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>
              [
                _buildDatePicker(),
                _buildAmountPicker("Adultos (13+ anos)", _adultController, true),
                _buildAmountPicker("Crianças (4 - 12 anos)", _kidController, false),
                _buildPriceAndButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _postFunctions()
  {
    setState(()
    {
      itemAmount = adultAmount + kidAmount;

      if(weekday == 6 || weekday == 7)
      {
        adultPrice = 58.00;
        kidPrice = 34.00;
      }
      else
      {
        adultPrice = 44.00;
        kidPrice = 28.00;
      }

      totalPrice = (adultPrice*adultAmount) + (kidPrice*kidAmount);
      _valueController.text = totalPrice.toString() + "0";
    });

    return Container();
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildBody();
  }
}