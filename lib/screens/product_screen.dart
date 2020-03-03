import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductScreen extends StatefulWidget
{
  final Map _productMap;

  ProductScreen(this._productMap);

  @override
  _ProductScreenState createState() => _ProductScreenState(_productMap);
}

class _ProductScreenState extends State<ProductScreen>
{
  final Map _productMap;
  String numbers = "0123456789";
  TextEditingController _fieldController;

  _ProductScreenState(this._productMap);

  Widget _buildBody()
  {
    Image _productImage = Image.network(_productMap["url"], fit: BoxFit.cover,);
    String _productName = _productMap["Nome"];
    double _productPrice = _productMap["preco"];

    return Scaffold
    (
      appBar: AppBar
      (
        title: Text
        (
          _productName,
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
          _productImage,
          Divider(),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>
            [
              Text("Quantidade"),
              IconButton(icon: Icon(Icons.remove), onPressed: (){},),
              Container
              (
                width: 50,
                child: TextField
                (
                  cursorColor: Color(0x00ffffff),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _fieldController,
                  inputFormatters: <TextInputFormatter>
                  [
                    LengthLimitingTextInputFormatter(1),
                    WhitelistingTextInputFormatter.digitsOnly,
                    BlacklistingTextInputFormatter.singleLineFormatter,
                  ],
                ),
              ),
              IconButton(icon: Icon(Icons.add), onPressed: (){},),
              Divider()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildBody();
  }
}