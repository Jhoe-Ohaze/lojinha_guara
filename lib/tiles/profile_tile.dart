import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget
{
  final Map _userData;
  ProfileTile(this._userData);
  @override
  _ProfileTileState createState() => _ProfileTileState(_userData);
}

class _ProfileTileState extends State<ProfileTile>
{
  final Map _userData;
  _ProfileTileState(this._userData);

  Widget _profileButton()
  {
    return Container
    (
      padding: EdgeInsets.only(right: 10, top: 10),
      alignment: Alignment.centerLeft,
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>
        [
          Stack
          (
            alignment: Alignment.center,
            children: <Widget>
            [
              ClipRRect
              (
                child: Container(decoration: BoxDecoration
                (
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white
                ), child: SizedBox(width: 84, height: 84),),
                borderRadius: BorderRadius.circular(8),
              ),
              ClipRRect
              (
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(width: 85, height: 85,
                child: Image.network(_userData["Foto"], fit: BoxFit.fitHeight, alignment: Alignment.topCenter),)
              )
            ]
          ),

          Container
          (
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row
            (
              children: <Widget>
              [
                Column
                  (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    SizedBox(height: 5),
                    Text("${_userData["usuario"]}", style: TextStyle(fontSize: 18, fontFamily: 'Fredoka')),
                    Row(children: <Widget>
                    [
                      Text("Meu perfil", style: TextStyle(fontSize: 12)),
                      Icon(Icons.chevron_right,size: 14,)
                    ])
                  ],
                ),
                Expanded(child: Container()),
                Column
                (
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>
                  [
                    Text("Resgistrado dia:", style: TextStyle(color: Colors.redAccent, fontSize: 10)),
                    Text("20/03/2020", style: TextStyle(color: Colors.redAccent, fontSize: 10),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Material
    (
      color: Colors.transparent,
      child: Stack
      (
        alignment: Alignment.center,
        children: <Widget>
        [
          _profileButton(),
          InkWell
          (
            onTap: () async
            {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("tap")));
            },
          ),
        ],
      )
    );
  }
}
