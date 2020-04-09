import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/my_assets/icon_assets.dart';
import 'package:lojinha_guara/tabs/excursion_tab.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/tabs/society_tab.dart';
import 'package:lojinha_guara/tabs/ticket_tab.dart';
import 'package:lojinha_guara/tiles/drawer_tiles.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
import 'package:lojinha_guara/tiles/exit_tile.dart';
import 'package:lojinha_guara/tiles/login_tile.dart';


class CustomDrawer extends StatefulWidget
{
  final Function _setWidget;
  final Function _getPage;
  final Function _setUser;
  final Function _logOut;

  CustomDrawer
  (
    this._setWidget,
    this._getPage,
    this._setUser,
    this._logOut,
  );

  @override
  _CustomDrawerState createState() => _CustomDrawerState(_setWidget, _getPage, _setUser, _logOut);
}

class _CustomDrawerState extends State<CustomDrawer>
{
  final Function _setWidget;
  final Function _getPage;
  final Function _setUser;
  final Function _logOut;
  FirebaseUser _user;

  _CustomDrawerState
  (
    this._setWidget,
    this._getPage,
    this._setUser,
    this._logOut,
  );

  @override
  void initState()
  {
    super.initState();
    initUser();
  }

  void initUser() async
  {
    await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context)
  {
    return Drawer
    (
      child: Stack
      (
        children: <Widget>
        [
          ListView
          (
            children: <Widget>
            [
              Container
              (
                height: 110,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration
                (
                  gradient: LinearGradient
                  (
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:
                    [
                      Color(0xFF1133FF),
                      Color(0xAA0055FF),
                      Color(0x780088CC),
                      Color(0x4400FFFF),
                      Color(0x00FFFFFF)
                    ]
                  ),
                ),
                child: ImageAssets.logoImage,
              ),

              Divider(color: Colors.grey[300], thickness: 1, height: 2),
              Padding(padding: EdgeInsets.only(top: 5)),

              LogInTile(_setUser, _user),
              Divider(color: Colors.grey[300], thickness: 1),

              DrawerTile(Icons.home, "Início", HomeTab(_setWidget), _setWidget, _getPage, 0),
              Divider(color: Colors.grey[300], thickness: 1),

              DrawerTile(IconAssets.ticket, "Comprar Bilhete", TicketTab(), _setWidget, _getPage, 1),
              DrawerTile(Icons.directions_bus, "Excursões", ExcursionTab(), _setWidget, _getPage, 2),
              DrawerTile(Icons.person, "Sociedade", SocietyTab(), _setWidget, _getPage, 3),

              Divider(color: Colors.grey[300], thickness: 1),
              ExitTile(_logOut),
              _user == null ? Container() : Divider()
            ],
          )
        ],
      ),
    );
  }
}