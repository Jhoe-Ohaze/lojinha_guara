import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/product_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductTab extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return _tabBody();
  }

  ///////////////////////////////////////////////////
  /////////////////* Main Widget *///////////////////
  Widget _tabBody()
  {
    return Column
    (
      children: <Widget>
      [
        AppBar
          (
          backgroundColor: Color(0xFFEE3522),
          title: Text
            (
            "Bilheteria",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
          centerTitle: true,
        ),

        Expanded
        (
          child: Stack
            (
            children: <Widget>
            [
              _buildProducts(), //Products Slivers
            ],
          ),
        )
      ],
    );
  }
  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////

  ///////////////////////////////////////////////////
  ///////////////* Products Slivers *////////////////
  Widget _buildProducts()
  {
    return Container();
  }
  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////
}

