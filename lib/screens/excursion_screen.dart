import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';

class ExcursionScreen extends StatefulWidget
{
  @override
  _ExcursionScreenState createState() => _ExcursionScreenState();
}

class _ExcursionScreenState extends State<ExcursionScreen>
{
  int weekday;
  double _screenWidth;
  double _screenHeight;
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

  @override
  Widget build(BuildContext context)
  {
     _screenWidth = MediaQuery.of(context).size.width;
     _screenHeight = MediaQuery.of(context).size.height;

    Widget _createField(label, isEditable, width, limit, isNumeric, isDDD)
    {
      return Container
      (
        width: width,
        padding: EdgeInsets.all(5),
        child: TextField
        (
          textCapitalization: TextCapitalization.characters,
          readOnly: !isEditable,
          textAlign: isDDD ? TextAlign.center : TextAlign.left,
          decoration: InputDecoration
          (
            labelText: label,
            border: OutlineInputBorder(),
          ),
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumeric ? <TextInputFormatter>
          [
            LengthLimitingTextInputFormatter(limit),
            WhitelistingTextInputFormatter.digitsOnly,
          ] : 
          <TextInputFormatter>
          [
            LengthLimitingTextInputFormatter(limit),
            WhitelistingTextInputFormatter(RegExp("[A-Z ]")),
          ],
        ),
      );
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

    Widget _buildDatePicker()
    {
      String initDate = DateFormat('dd/MM/yyyy').format(_selectedDate).toString();
      return Container
      (
        width: 125,
        padding: EdgeInsets.all(5),
        child: InkWell
        (
          onTap: () async
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
            child: TextField
            (
              enabled: false,
              readOnly: true,
              cursorColor: Color(0x00ffffff),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(),
              controller: _dateController,
              decoration: InputDecoration
              (
                labelText: "Data",
                border: OutlineInputBorder(),
              ),
            ),
          )
      );
    }

    Widget _buildTypePicker()
    {
      return Container
      (
        padding: EdgeInsets.all(5),
        width: _screenWidth - 135,
        alignment: Alignment.centerRight,
        child: InputDecorator
        (
          child: DropdownButtonHideUnderline
          (
            child: DropdownButton
            (
              value: dropdownValue,
              onChanged: (String newValue)
              {
                setState(()
                {
                  dropdownValue = newValue;
                });
              },
              items: <String>["Aniversário", "Passeio"].map<DropdownMenuItem<String>>((String value)
              {
                return DropdownMenuItem<String>
                (
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          decoration: new InputDecoration
          (
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            labelText:("Tipo de excursão"),
            enabledBorder:  OutlineInputBorder
            (
              borderSide: BorderSide
              (
                color: Colors.grey
              )
            ),
            border: OutlineInputBorder
            (
              borderSide: BorderSide(color: Colors.black)
            )
          )
        ),
      );
    }

    Widget _buildSendButton()
    {
      return SizedBox
      (
        height: MediaQuery.of(context).size.height*0.15,
        width: _screenWidth,
        child: Stack
        (
          alignment: Alignment.center,
          children: <Widget>
          [
            Container
            (
              height: double.infinity,
              child: ImageAssets.sendButtonImage,
            ),
            Container
            (
              decoration: BoxDecoration
              (
                borderRadius: BorderRadius.only(topLeft: Radius.circular(180), topRight: Radius.circular(180))
              ),
              alignment: Alignment.center,
              width: _screenWidth*0.5,
              height: double.infinity,
              child: MaterialButton
              (
                shape: RoundedRectangleBorder
                (
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(250), topRight: Radius.circular(250))
                ),
                onPressed: ()
                {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Tap")));
                },
                child: Container
                  (
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  child: Text
                  (
                    "Solicitar",
                    style: TextStyle
                      (
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildBody()
    {
      return Column
        (
        children: <Widget>
        [
          Container
            (
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Column
              (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                _createField("Nome", true, _screenWidth, 100, false, false),
                Row
                  (
                  children: <Widget>
                  [
                    _createField("DDD", true, 70.0, 2, true, true),
                    _createField("Telefone", true, _screenWidth-80, 9, true, false),
                  ],
                ),
                Row
                  (
                  children: <Widget>
                  [
                    _buildDatePicker(),
                    _buildTypePicker()
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          _buildSendButton(),
        ],
      );
    }

    return SizedBox
      (
        height: _screenHeight,
        width: _screenWidth,
        child: _buildBody()
    );
  }
}
