import 'package:flutter/material.dart';

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
            children: <Widget>
            [
              Text("Quantidade"),
              IconButton(icon: Icon(Icons.remove), onPressed: (){},),
              TextField
              (
                keyboardType: TextInputType.numberWithOptions(),
                controller: _fieldController,
              )
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