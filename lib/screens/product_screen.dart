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
  int itemAmount = 0;

  _ProductScreenState(this._productMap);

  @override
  void initState()
  {
    super.initState();
    _fieldController = new TextEditingController(text: itemAmount.toString());
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              IconButton
              (
                padding: EdgeInsets.all(10.0),
                icon: Icon(Icons.remove_circle_outline),
                iconSize: 30.0,
                onPressed: ()
                {
                  setState(()
                  {
                    if(itemAmount > 0)
                    {
                      itemAmount--;
                      _fieldController.text = itemAmount.toString();
                    }
                  });
                }
               ),

              Container
              (
                width: 60,
                child: TextField
                (
                  readOnly: true,
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
                  decoration: InputDecoration
                  (
                    border: OutlineInputBorder()
                  ),
                ),
              ),

              IconButton
              (
                padding: EdgeInsets.all(10.0),
                icon: Icon(Icons.add_circle_outline),
                iconSize: 30.0,
                onPressed: ()
                {
                  setState(()
                  {
                    if(itemAmount < 9)
                    {
                      itemAmount++;
                      _fieldController.text = itemAmount.toString();
                    }
                  });
                }
              ),
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