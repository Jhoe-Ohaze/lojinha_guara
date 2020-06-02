import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget
{
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
{

  Future<Map> _getPage() async
  {
    http.Response response;
    String url = "https://cieloecommerce.cielo.com.br/api/public/v1/orders";
    
    response = await http.post(url,
      headers: <String, String>
      {
        'Content-Type': 'application/json',
        'MerchantId' : '8df7525e-666d-4c23-bd49-3a4496f3dfb0'
      },
      body: jsonEncode(<String, dynamic>
      {
        "OrderNumber":"0",
        "SoftDescriptor":"Test",
        "Cart":{
          "Discount":{
            "Type":"Percent",
            "Value":00
          },
          "Items":[
            {
              "Name":"Test",
              "Description":"Test",
              "UnitPrice":100,
              "Quantity":1,
              "Type":"Asset",
              "Sku":"ABC001",
              "Weight":0
            }
          ]
        },
        "Shipping":{
          "SourceZipCode":"",
          "TargetZipCode":"",
          "Type":"WithoutShippingPickUp",
          "Services":[],
          "Address":{
            "Street":"",
            "Number":"",
            "Complement":"",
            "District":"",
            "City":"",
            "State":""
          }
        },
        "Payment":{
          "BoletoDiscount":0,
          "DebitDiscount":0,
          "Installments":null,
          "MaxNumberOfInstallments": null
        },
        "Customer":{
          "Identity":"",
          "FullName":"",
          "Email":"",
          "Phone":""
        },
        "Options":{
          "AntifraudEnabled":true,
          "ReturnUrl": ""
        },
        "Settings":null
      }));

    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(),
      body: FutureBuilder
      (
        future: _getPage(),
        builder: (context, snapshot)
        {
          switch(snapshot.connectionState)
          {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              String url = snapshot.data["settings"]["checkoutUrl"];
              print(url);
              return WebView(initialUrl: url, javascriptMode: JavascriptMode.unrestricted);
          }
        },
      ),
    );
  }
}
