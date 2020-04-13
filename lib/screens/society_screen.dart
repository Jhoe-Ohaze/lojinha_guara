import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';

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

  Widget _buildSendButton()
  {
    double _screenWidth = MediaQuery.of(context).size.width;

    void sendData() async
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
            child: ImageAssets.sendButtonImage
          ),
          Container
          (
            alignment: Alignment.center,
            width: _screenWidth*0.5,
            height: double.infinity,
            decoration: BoxDecoration
            (
              borderRadius: BorderRadius.only(topLeft: Radius.circular(180), topRight: Radius.circular(180))
            ),
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

  Widget _buildBody(context)
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
            ],
          ),
        ),
        Expanded(child: Container()),
        _buildSendButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildBody(context);
  }
}
