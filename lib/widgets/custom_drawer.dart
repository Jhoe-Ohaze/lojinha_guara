import 'package:flutter/material.dart';
import 'package:lojinha_guara/tiles/drawer_tiles.dart';

class CustomDrawer extends StatelessWidget
{
  final PageController pageController;

  CustomDrawer(this.pageController);

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
                child: Image.asset('my_assets/logo_drawer.png', alignment: Alignment.bottomCenter),
              ),
              Divider(color: Colors.grey[300], thickness: 2, height: 2,),
              Padding(padding: EdgeInsets.only(top: 5),),
              DrawerTile(Icons.home, "Início", pageController, 0),
              Divider(color: Colors.grey[300], thickness: 2),
              DrawerTile(Icons.shopping_cart, "Bilheteria", pageController, 1),
              DrawerTile(Icons.date_range, "Excursões", pageController, 2),
              DrawerTile(Icons.location_on, "Encontre-nos", pageController, 3),
              DrawerTile(Icons.calendar_today, "Calendario", pageController, 4),
            ],
          )
        ],
      ),
    );
  }
}
