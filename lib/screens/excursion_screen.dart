import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  final nomeController = TextEditingController();
  final dddController = TextEditingController();
  final telController = TextEditingController();

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

    Widget _createField(String label, double width, int limit, bool isNumeric, bool isDDD, TextEditingController controller)
    {
      return Container
      (
        width: width,
        padding: EdgeInsets.all(5),
        child: TextField
        (
          controller: controller,
          textCapitalization: TextCapitalization.characters,
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
              );

              case 2:
                double width = MediaQuery.of(context).size.width;
                double height = MediaQuery.of(context).size.height;

                return Container
                (
                  color: Color(0x11BBBBBB),
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: SizedBox
                  (
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  )
                );

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

    Widget _buildTypePicker()
    {
      return Container
      (
        padding: EdgeInsets.all(5),
        width: _screenWidth - 175,
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
      void sendData() async
      {
        setState(() => _showDialog(2));
        QuerySnapshot snapshot = await Firestore.instance.collection('vendedores').orderBy('Nome').getDocuments();
        List<DocumentSnapshot> consultorList = snapshot.documents.toList();

        snapshot = await Firestore.instance.collection('excursao').orderBy('DataExpedicao', descending: true).limit(1).getDocuments();
        if(snapshot.documents.length == 0)
        {
          String nome = nomeController.text;
          int telefone = int.parse(dddController.text + telController.text);

          Firestore.instance.collection('excursao').add
          (
            {
              "Numero": telefone,
              "LigacaoPendente": true,
              "Vendedor": consultorList.elementAt(0).data["Nome"],
              "Nome": nome,
              "Tipo": dropdownValue,
              "DataSolicitada": _selectedDate,
              "DataExpedicao": DateTime.now(),
              "DataLigacao": null,
            }
          );

          nomeController.clear();
          dddController.clear();
          telController.clear();
        }
        else
        {
          DocumentSnapshot lastDocument = snapshot.documents.elementAt(0);

          String lastCons = lastDocument.data['Vendedor'];
          String nextCons = "";
          int count = 0;
          for(DocumentSnapshot doc in consultorList)
          {
            count++;
            if(lastCons == doc.data['Nome'])
            {
              if(count >= consultorList.length)
                nextCons = consultorList.elementAt(0).data['Nome'];
              else
                nextCons = consultorList.elementAt(count).data['Nome'];
            }
          }

          String nome = nomeController.text;
          int telefone = int.parse(dddController.text + telController.text);

          Firestore.instance.collection('excursao').add
            (
              {
                "Numero": telefone,
                "LigacaoPendente": true,
                "Vendedor": nextCons,
                "Tipo": dropdownValue,
                "Nome": nome,
                "DataSolicitada": _selectedDate,
                "DataExpedicao": DateTime.now(),
                "DataLigacao": null,
              }
          );

          nomeController.clear();
          dddController.clear();
          telController.clear();
          FocusScope.of(context).requestFocus(FocusNode());
        }

        setState(()
        {
          Navigator.of(context).pop();
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Solicitação Enviada")));
        });
      }

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
                onPressed: sendData,
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
            child: SingleChildScrollView
            (
              physics: BouncingScrollPhysics(),
              child: Column
                (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                  _createField("Nome", _screenWidth, 100, false, false, nomeController),
                  Row
                    (
                    children: <Widget>
                    [
                      _createField("DDD", 70.0, 2, true, true, dddController),
                      _createField("Telefone", _screenWidth-80, 9, true, false, telController),
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
            )
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
