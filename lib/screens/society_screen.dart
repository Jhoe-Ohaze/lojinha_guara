import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SocietyScreen extends StatefulWidget 
{
  @override
  _SocietyScreenState createState() => _SocietyScreenState();
}

class _SocietyScreenState extends State<SocietyScreen> 
{
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

  Widget _buildSendButton()
  {
    double _screenWidth = MediaQuery.of(context).size.width;
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
            child: Image.asset
            (
              'my_assets/images/send_button.png',
              fit: BoxFit.fill,
              color: Color.fromRGBO(255, 255, 255, 0.8),
              colorBlendMode: BlendMode.modulate,
            ),
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
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Tap"),));
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

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Column
      (
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>
      [
        Container
        (
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Column
          (
            children: <Widget>
            [
              _createField("Nome", true, _screenWidth, 100, false, false),
              Row
                (
                children: <Widget>
                [
                  _createField("DDD", true, 70.0, 2, true, true),
                  _createField("Telefone", true, 120.0, 9, true, false),
                  _createField("CPF", true, _screenWidth - 200, 11, true, false)
                ],
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        _buildSendButton()
      ],
    );
  }
}
