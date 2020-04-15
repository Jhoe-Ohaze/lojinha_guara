import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';

class SigninScreen extends StatefulWidget
{
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
{
  FirebaseUser _currentUser;
  DateTime _currentDate = DateTime.now();

  TextEditingController _dateController;
  final _nameController = TextEditingController();
  final _dddController = TextEditingController();
  final _telController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width;

    void _initUser() async
    {
      _currentUser = await FirebaseAuth.instance.currentUser();
    }

    Widget _createField(label, width, limit, isNumeric, isDDD, TextEditingController _controller)
    {
      return Container
        (
        width: width,
        padding: EdgeInsets.all(5),
        child: TextField
          (
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          textAlign: isDDD ? TextAlign.center : TextAlign.left,
          onChanged: (text){print(_controller.text);},
          decoration: InputDecoration
            (
            labelText: label,
            border: OutlineInputBorder(),
          ),
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
          controller: _controller,
        ),
      );
    }

    Widget _buildDatePicker()
    {
      String initDate = DateFormat('dd/MM/yyyy').format(_currentDate).toString();
      return Container
        (
          width: 165,
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          child: InkWell
            (
              onTap: () async
              {
                DateTime selectedDate = await showDatePicker
                  (
                    context: context,
                    initialDate: _currentDate,
                    firstDate: DateTime(1920, 1, 1),
                    lastDate: _currentDate,
                    builder: (context, child)
                    {
                      return Theme
                        (
                        data: ThemeData.light(),
                        child: child,
                      );
                    }
                );
              },
              child: InputDecorator
                (
                decoration: new InputDecoration
                  (
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                    labelText:("Data da Excursão"),
                    enabledBorder:  OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    border: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.black)
                    )
                ),
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
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),
                ),
              )
          )
      );
    }

    _initUser();
    return Scaffold
      (
      body: SingleChildScrollView
        (
        physics: BouncingScrollPhysics(),
        child: Stack
          (
          children: <Widget>
          [
            Column
              (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                SizedBox(height: 120),
                Container
                  (
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column
                    (
                    children: <Widget>
                    [
                      _createField("Nome Completo", _screenWidth-20, 100, false, false, _nameController),
                      Row
                        (
                        children: <Widget>
                        [
                          _createField("DDD", 70.0, 2, true, true, _dddController),
                          _createField("Telefone", 120.0, 9, true, false, _telController),
                          _createField("CPF", _screenWidth - 200, 11, true, false, _cpfController),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            CustomBar("Cadastre-se")
          ],
        ),
      ),
    );
  }
}