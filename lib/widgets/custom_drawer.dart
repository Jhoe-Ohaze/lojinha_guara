import 'package:flutter/material.dart';
import 'package:lojinha_guara/tiles/drawer_tiles.dart';

class CustomDrawer extends StatelessWidget
{
  final PageController pageController;
  final TextEditingController titleController;

  CustomDrawer(this.pageController, this.titleController);

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

              Divider(color: Colors.grey[300], thickness: 1, height: 2),
              Padding(padding: EdgeInsets.only(top: 5)),

              DrawerTile(Icons.home, "Início", pageController, 0, titleController),
              Divider(color: Colors.grey[300], thickness: 1),

              DrawerTile(Icons.local_offer, "Bilheteria", pageController, 1, titleController),
              DrawerTile(Icons.directions_bus, "Excursões", pageController, 2, titleController),
              DrawerTile(Icons.person, "Sociedade", pageController, 3, titleController),
              DrawerTile(Icons.location_on, "Encontre-nos", pageController, 4, titleController),
              DrawerTile(Icons.calendar_today, "Calendario", pageController, 5, titleController),
            ],
          )
        ],
      ),
    );
  }
}
