import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget
{
  final Map _userData;
  ProfileScreen(this._userData);
  @override
  _ProfileScreenState createState() => _ProfileScreenState(_userData);
}

class _ProfileScreenState extends State<ProfileScreen>
{
  final Map _userData;
  _ProfileScreenState(this._userData);

  Widget _buildBody()
  {
    return Scaffold
    (
      appBar: AppBar
      (
        centerTitle: true,
        title: Text("Conta"),
        leading: GestureDetector
        (
          onTap: (){Navigator.of(context).pop();},
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView
      (
        padding: EdgeInsets.all(10),
        children: <Widget>
        [
          Container
          (
            height: 200,
            child: Column(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
