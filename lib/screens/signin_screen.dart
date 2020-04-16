import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget
{
  final Function _logOut;
  SignInScreen(this._logOut);

  @override
  _SignInScreenState createState() => _SignInScreenState(_logOut);
}

class _SignInScreenState extends State<SignInScreen>
{
  final Function _logOut;
  _SignInScreenState(this._logOut);

  FirebaseUser _currentUser;

  final _nomeController = TextEditingController();
  final _dddController = TextEditingController();
  final _telController = TextEditingController();
  final _cpfController = TextEditingController();
  final _adrController = TextEditingController();
  final _numController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width;

    void _initUser() async
    {
      _currentUser = await FirebaseAuth.instance.currentUser();
    }

    @override
    void initState()
    {
      super.initState();
      _initUser();
    }

    void _showLoading()
    {
      showDialog
        (
          context: context,
          builder: (context)
          {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            return Container
              (
                color: Colors.black26,
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
          }
      );
    }

    Widget _createField(label, width, limit, isNumeric, isDDD, TextEditingController _controller)
    {
      return Container
        (
        width: width+0.00,
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
      void sendData() async
      {
        _showLoading();
        try
        {
          QuerySnapshot snapshot = await Firestore.instance.collection('consultores').orderBy('Nome').getDocuments();
          List<DocumentSnapshot> consultorList = snapshot.documents.toList();

          snapshot = await Firestore.instance.collection('sociedade').orderBy('DataExpedicao', descending: true).limit(1).getDocuments();
          if(snapshot.documents.length == 0)
          {
            String nome = _nomeController.text;
            int telefone = int.parse(_dddController.text + _telController.text);
            int cpf = int.parse(_cpfController.text);

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

            _nomeController.clear();
            _dddController.clear();
            _telController.clear();
            _cpfController.clear();
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

            String nome = _nomeController.text;
            int telefone = int.parse(_dddController.text + _telController.text);
            int cpf = int.parse(_cpfController.text);

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

            _nomeController.clear();
            _dddController.clear();
            _telController.clear();
            _cpfController.clear();
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
          color: Colors.redAccent,
          child: Text("Finalizar Cadastro", style: TextStyle(color: Colors.white)),
          onPressed: sendData,
        ),
      );
    }

    Widget _buildScreen()
    {
      return Scaffold
      (
        appBar: AppBar
        (
          centerTitle: true,
          title: Text('Cadastre-se'),
          leading: GestureDetector
          (
            onTap: (){_logOut(); Navigator.of(context).pop();},
            child: Icon(Icons.arrow_back),
          ),
        ),
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
                  Container
                    (
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column
                      (
                      children: <Widget>
                      [
                        _createField("Nome Completo", _screenWidth-10, 100, false, false, _nomeController),
                        Row
                          (
                          children: <Widget>
                          [
                            _createField("DDD", 70.0, 2, true, true, _dddController),
                            _createField("Telefone", 120.0, 9, true, false, _telController),
                            _createField("CPF", _screenWidth - 200, 11, true, false, _cpfController),
                          ],
                        ),
                        Row
                          (
                          children: <Widget>
                          [
                            _createField("Endereço", _screenWidth-110, 100, false, false, _adrController),
                            _createField("Número", 100 , 5, true, true, _numController),
                          ],
                        ),
                        Row
                          (
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget> [_buildSendButton()],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    _initUser();
    return WillPopScope
    (
      child: _buildScreen(),
      onWillPop: (){_logOut(); return Future(()=>true);},
    );
  }
}