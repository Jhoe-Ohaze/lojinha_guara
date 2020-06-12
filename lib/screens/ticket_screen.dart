import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
import 'package:lojinha_guara/screens/payment_screen.dart';

class PreLoadTicketScreen extends StatefulWidget
{
  @override
  _PreLoadTicketScreenState createState() => _PreLoadTicketScreenState();
}

class _PreLoadTicketScreenState extends State<PreLoadTicketScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Container();
  }
}

class TicketScreen extends StatefulWidget
{
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
{
  TextEditingController _adultController;
  TextEditingController _kidController;
  TextEditingController _valueController;

  int itemAmount = 0;
  int adultAmount = 0;
  int kidAmount = 0;

  DateTime _currentDate;
  DateTime _selectedDate;

  double adultPrice = 0.00;
  double kidPrice = 0.00;
  double totalPrice = 0.00;

  bool firstRun = true;
  bool isButtonEnabled = false;

  int weekday = 0;

  QuerySnapshot snapshot;
  List<DocumentSnapshot> priceList;

  @override
  void initState()
  {
    initPrices();
    super.initState();
    _adultController = new TextEditingController(text: adultAmount.toString());
    _kidController = new TextEditingController(text: kidAmount.toString());

    _currentDate = DateTime.now().weekday == 2 ? DateTime.now().add(Duration(days: 1)) : DateTime.now();
    _selectedDate = _currentDate;
    _valueController = new TextEditingController(text: "0.00");
  }

  void initPrices() async => await setFirstPrices();

  Future<void> setFirstPrices() async
  {
    snapshot = await Firestore.instance.collection('preco_bilheteria').orderBy('Nome').getDocuments();
    priceList = snapshot.documents.toList();

    if(weekday == 6 || weekday == 7)
    {
      for(DocumentSnapshot doc in priceList)
      {
        if(doc.data['Nome'] == "Adulto FDS")
          adultPrice = doc.data['Valor'] + 0.00;
        if(doc.data['Nome'] == "Criança FDS")
          kidPrice = doc.data['Valor'] + 0.00;
      }
    }
    else
    {
      for(DocumentSnapshot doc in priceList)
      {
        if(doc.data['Nome'] == "Adulto Semana")
          adultPrice = doc.data['Valor'] + 0.00;
        if(doc.data['Nome'] == "Criança Semana")
         kidPrice = doc.data['Valor'] + 0.00;
      }
    }
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
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            return Container
            (
              margin: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.15),
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
                    },
                    child: ImageAssets.excDialogImage,
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
            content: Text("O Park estará fechado na data selecionada", textAlign: TextAlign.justify),
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
            content: Text("A quantidade de ingressos é 0", textAlign: TextAlign.justify),
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
                        _postFunctions();
                      }
                    });
                  },
                ),

                Container
                (
                  width: 60,
                  child: TextField
                  (
                    cursorColor: Color(0x00ffffff),
                    textAlign: TextAlign.center,
                    enabled: false,
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
                        _postFunctions();
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
  
  Widget _buildCalendar(DateTime maxDate)
  {
    EventList<Event> _markedDateMap = new EventList<Event>
      (
        events:
        {

        }
    );
    
    return Container
      (
      margin: EdgeInsets.all(5),
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
        maxSelectedDate: maxDate,

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
                    child: Text("R\$", style: TextStyle(fontSize: 16)),
                  ),
                  Container
                    (
                    padding: EdgeInsets.only(right: 10),
                    width: 90,
                    child: TextField
                      (
                      enabled: false,
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
                  height: 52,
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(8),
                    color: isButtonEnabled ? Colors.redAccent : Color(0x66CC2222)
                  ),
                  margin: EdgeInsets.only(left: 5),
                  child: MaterialButton
                  (

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: TextField
                    (
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration
                      (
                        hintText: "Finalizar Compra",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none
                      ),
                    ),
                    onPressed: isButtonEnabled ? GoToCheckout : null,
                  ),
                )
            )
          ],
        )
    );
  }

  void GoToCheckout()
  {
    if(itemAmount == 0)
    {
      _showDialog(2);
    }
    else
    {
      Map<String, dynamic> checkoutMap;
      int year = _selectedDate.year;
      int month = _selectedDate.month;
      int day = _selectedDate.day;

      if(kidAmount > 0 && adultAmount == 0)
      {
        checkoutMap = {
          "OrderNumber":"0",
          "SoftDescriptor":"Compra de bilhetes para $day/$month/$year",
          "Cart":{
            "Discount":{
              "Type":"Percent",
              "Value":00
            },
            "Items":
            [
              {
                "Name":"Ingresso infantil",
                "Description":"",
                "UnitPrice":100*kidPrice.toInt(),
                "Quantity":kidAmount,
                "Type":"Asset",
                "Sku":"ABC001",
                "Weight":0
              },
            ]
          },
          "Shipping":{
            "SourceZipCode":"",
            "TargetZipCode":"",
            "Type":"WithoutShippingPickUp",
            "Services":[],
            "Address":{
              "Street":"",
              "Number":"",
              "Complement":"",
              "District":"",
              "City":"",
              "State":""
            }
          },
          "Payment":{
            "BoletoDiscount":0,
            "DebitDiscount":0,
            "Installments":null,
            "MaxNumberOfInstallments": null
          },
          "Customer":{
            "Identity":"",
            "FullName":"",
            "Email":"",
            "Phone":""
          },
          "Options":{
            "AntifraudEnabled":true,
            "ReturnUrl": ""
          },
          "Settings":null
        };
      }
      else if(adultAmount > 0 && kidAmount == 0)
      {
        checkoutMap = {
          "OrderNumber":"0",
          "SoftDescriptor":"Test",
          "Cart":{
            "Discount":{
              "Type":"Percent",
              "Value":00
            },
            "Items":
            [
              {
                "Name":"Ingresso adulto",
                "Description":"",
                "UnitPrice":100*adultPrice.toInt(),
                "Quantity":adultAmount,
                "Type":"Asset",
                "Sku":"ABC001",
                "Weight":0
              }
            ]
          },
          "Shipping":{
            "SourceZipCode":"",
            "TargetZipCode":"",
            "Type":"WithoutShippingPickUp",
            "Services":[],
            "Address":{
              "Street":"",
              "Number":"",
              "Complement":"",
              "District":"",
              "City":"",
              "State":""
            }
          },
          "Payment":{
            "BoletoDiscount":0,
            "DebitDiscount":0,
            "Installments":null,
            "MaxNumberOfInstallments": null
          },
          "Customer":{
            "Identity":"",
            "FullName":"",
            "Email":"",
            "Phone":""
          },
          "Options":{
            "AntifraudEnabled":true,
            "ReturnUrl": ""
          },
          "Settings":null
        };
      }
      else
      {
        checkoutMap = {
          "OrderNumber":"0",
          "SoftDescriptor":"Test",
          "Cart":{
            "Discount":{
              "Type":"Percent",
              "Value":00
            },
            "Items":
            [
              {
                "Name":"Ingresso infantil",
                "Description":"",
                "UnitPrice":100*kidPrice.toInt(),
                "Quantity":kidAmount,
                "Type":"Asset",
                "Sku":"ABC001",
                "Weight":0
              },
              {
                "Name":"Ingresso adulto",
                "Description":"",
                "UnitPrice":100*adultPrice.toInt(),
                "Quantity":adultAmount,
                "Type":"Asset",
                "Sku":"ABC001",
                "Weight":0
              }
            ]
          },
          "Shipping":{
            "SourceZipCode":"",
            "TargetZipCode":"",
            "Type":"WithoutShippingPickUp",
            "Services":[],
            "Address":{
              "Street":"",
              "Number":"",
              "Complement":"",
              "District":"",
              "City":"",
              "State":""
            }
          },
          "Payment":{
            "BoletoDiscount":0,
            "DebitDiscount":0,
            "Installments":null,
            "MaxNumberOfInstallments": null
          },
          "Customer":{
            "Identity":"",
            "FullName":"",
            "Email":"",
            "Phone":""
          },
          "Options":{
            "AntifraudEnabled":true,
            "ReturnUrl": ""
          },
          "Settings":null
        };
      }

      Navigator.of(context).push
        (
          MaterialPageRoute(builder: (context) => PaymentScreen(checkoutMap))
      );
    }
  }

  Widget _buildBody()
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Comprar bilhete", style: TextStyle(fontFamily: "Fredoka")),
        centerTitle: true,
      ),
      body: SingleChildScrollView
      (
        physics: BouncingScrollPhysics(),
        child: Container
          (
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          child: Column
            (
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>
            [
              _buildCalendar(DateTime(2021)),
              _buildAmountPicker("Adultos (13+ anos)", _adultController, true),
              _buildAmountPicker("Crianças (4 - 12 anos)", _kidController, false),
              _buildPriceAndButton(),
            ],
          ),
        )
      ),
    );
  }

  void _postFunctions()
  {
    setState(()
    {
      itemAmount = adultAmount + kidAmount;
      totalPrice = (adultPrice*adultAmount) + (kidPrice*kidAmount);
      _valueController.text = totalPrice.toString() + "0";
      isButtonEnabled = (itemAmount > 0);
    });
  }

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Container
      (
        height: _screenHeight,
        width: _screenWidth,
        child: _buildBody()
    );
  }
}

