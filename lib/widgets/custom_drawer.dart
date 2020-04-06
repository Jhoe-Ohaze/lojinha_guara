import 'package:flutter/material.dart';
import 'package:lojinha_guara/tabs/excursion_tab.dart';
import 'package:lojinha_guara/tabs/home_tab.dart';
import 'package:lojinha_guara/tabs/map_tab.dart';
import 'package:lojinha_guara/tabs/society_tab.dart';
import 'package:lojinha_guara/tabs/ticket_tab.dart';
import 'package:lojinha_guara/tiles/drawer_tiles.dart';

class CustomDrawer extends StatelessWidget
{
  final Widget _currentWidget;
  final Function _setWidget;
  final Function _getPage;

  CustomDrawer(this._currentWidget, this._setWidget, this._getPage);

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
                      Color(0xFF0022FF),
                      Color(0xAA0055FF),
                      Color(0x780088CC),
                      Color(0x4400FFFF),
                      Color(0x00FFFFFF)
                    ]
                  ),
                ),
                child: Image.asset('my_assets/images/logo_drawer.png', alignment: Alignment.bottomCenter),
              ),

              Divider(color: Colors.grey[300], thickness: 1, height: 2),
              Padding(padding: EdgeInsets.only(top: 5)),

              DrawerTile(Icons.home, "Início", HomeTab(), _setWidget, _getPage, 0),
              Divider(color: Colors.grey[300], thickness: 1),

              DrawerTile(Icons.local_offer, "Bilheteria", TicketTab(), _setWidget, _getPage, 1),
              DrawerTile(Icons.directions_bus, "Excursões", ExcursionTab(), _setWidget, _getPage, 2),
              DrawerTile(Icons.person, "Sociedade", SocietyTab(), _setWidget, _getPage, 3),
              DrawerTile(Icons.location_on, "Encontre-nos", MapTab(), _setWidget, _getPage, 4),
            ],
          )
        ],
      ),
    );
  }
}
