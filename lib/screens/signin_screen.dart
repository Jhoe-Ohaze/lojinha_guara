import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget
{
  final Function _logOut;
  final Function _logIn;
  SignInScreen(this._logOut, this._logIn);

  @override
  _SignInScreenState createState() => _SignInScreenState(_logOut, _logIn);
}

class _SignInScreenState extends State<SignInScreen>
{
  final Function _logOut;
  final Function _logIn;
  _SignInScreenState(this._logOut, this._logIn);

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

    void _initUser() async => _currentUser = await FirebaseAuth.instance.currentUser();

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
                title: Text("Erro", textAlign: TextAlign.center,),
                content: Text("Erro ao tentar se cadastrar, tente novamente", textAlign: TextAlign.justify,),
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
              default: return null;
            }
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

    Widget _buildRegisterButton()
    {
      void sendData() async
      {
        _showLoading();
        try
        {
          await Firestore.instance.collection('users').add
          (
            {
              "uid": _currentUser.uid,
              "usuario": _currentUser.displayName,
              "Nome": _nomeController.text,
              "Foto": _currentUser.photoUrl,
              "Email": _currentUser.email,
              "CPF": int.parse(_cpfController.text),
              "Telefone": int.parse(_dddController.text + _telController.text),
              "Endereço": "${_adrController.text}, ${_numController.text}",
            }
          );

          _nomeController.clear();
          _dddController.clear();
          _telController.clear();
          _cpfController.clear();
          _adrController.clear();
          _numController.clear();

          setState(()
          {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });

          _logIn();
        }

        catch(e)
        {
          setState(()
          {
            _logOut();
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.of(context).pop();
            _showDialog(1);
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
                          children: <Widget> [_buildRegisterButton()],
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