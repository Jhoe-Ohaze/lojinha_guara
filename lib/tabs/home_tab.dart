import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget
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

