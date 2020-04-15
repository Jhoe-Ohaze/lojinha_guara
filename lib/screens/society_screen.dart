import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojinha_guara/my_assets/color_assets.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';

class SocietyScreen extends StatefulWidget 
{
  @override
  _SocietyScreenState createState() => _SocietyScreenState();
}

class _SocietyScreenState extends State<SocietyScreen> 
{
  final nomeController = TextEditingController();
  final dddController = TextEditingController();
  final telController = TextEditingController();
  final cpfController = TextEditingController();

  Color primColor = ColorAssets.primaryColor;
  Color secoColor = ColorAssets.secondaryColor;
  Color contColor = ColorAssets.contentColor;
  Color inacColor = ColorAssets.inactiveColor;

  void _showDialog(int option)
  {
    showDialog
      (
        context: context,
        builder: (context)
        {
          switch(option)
          {
            case 2:
              double width = MediaQuery.of(context).size.width;
              double height = MediaQuery.of(context).size.height;

              return Container
                (
                  color: inacColor,
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

  Widget _buildSendButton()
  {
    double _screenWidth = MediaQuery.of(context).size.width;

    void sendData() async
    {
      _showDialog(2);
      try
      {
        QuerySnapshot snapshot = await Firestore.instance.collection('consultores').orderBy('Nome').getDocuments();
        List<DocumentSnapshot> consultorList = snapshot.documents.toList();

        snapshot = await Firestore.instance.collection('sociedade').orderBy('DataExpedicao', descending: true).limit(1).getDocuments();
        if(snapshot.documents.length == 0)
        {
          String nome = nomeController.text;
          int telefone = int.parse(dddController.text + telController.text);
          int cpf = int.parse(cpfController.text);

          Firestore.instance.collection('sociedade').add
            (
              {
                "Numero": telefone,
                "LigacaoPendente": true,
                "Consultor": consultorList.elementAt(0).data["Nome"],
                "Nome": nome,
                "CPF": cpf,
                "DataExpedicao": DateTime.now(),
                "DataLigacao": null,
              }
          );

          nomeController.clear();
          dddController.clear();
          telController.clear();
          cpfController.clear();
        }
        else
        {
          DocumentSnapshot lastDocument = snapshot.documents.elementAt(0);

          String lastCons = lastDocument.data['Consultor'];
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
          int cpf = int.parse(cpfController.text);

          Firestore.instance.collection('sociedade').add
            (
              {
                "Numero": telefone,
                "LigacaoPendente": true,
                "Consultor": nextCons,
                "Nome": nome,
                "CPF": cpf,
                "DataExpedicao": DateTime.now(),
                "DataLigacao": null,
              }
          );

          nomeController.clear();
          dddController.clear();
          telController.clear();
          cpfController.clear();
        }

        setState(()
        {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.of(context).pop();
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Solicitação Enviada")));
        });
      }
      catch(e)
      {
        setState(()
        {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.of(context).pop();
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Erro ao enviar solicitação")));
        });
      }
    }

    return Container
    (
      margin: EdgeInsets.all(5),
      height: 52,
      child: MaterialButton
      (
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: secoColor,
        child: Text("Enviar", style: TextStyle(color: contColor)),
        onPressed: sendData,
      ),
    );
  }

  Widget _buildBody()
  {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Stack
    (
      children: <Widget>
      [
        SizedBox
        (
          width: _screenWidth,
          height: _screenHeight,
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              SizedBox(height: 120),
              SingleChildScrollView
                (
                physics: BouncingScrollPhysics(),
                child: Column
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
                          _createField("Nome", _screenWidth, 100, false, false, nomeController),
                          Row
                            (
                            children: <Widget>
                            [
                              _createField("DDD", 70.0, 2, true, true, dddController),
                              _createField("Telefone", 120.0, 9, true, false, telController),
                              _createField("CPF", _screenWidth - 200, 11, true, false, cpfController)
                            ],
                          ),
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[_buildSendButton()],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        CustomBar("Quero Ser Sócio")
      ],
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildBody();
  }
}