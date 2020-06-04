import 'package:flutter/material.dart';

class ImageAssets
{
  static final String _root = "lib/my_assets/images/";
  static Image menuBlueImage(width) => Image.asset(_root+'menu_blue.png',
      alignment: Alignment.topLeft, width: width, fit: BoxFit.fill);

  static Image menuRedImage(width) => Image.asset(_root+'menu_red.png',
      alignment: Alignment.topLeft, width: width, fit: BoxFit.fill);

  static final Image drawerCard = Image.asset(_root+'drawer_card.png',
      fit: BoxFit.fill, width: 500);

  static final Image testFeedImage = Image.asset(_root+'test_feed.jpg',
      fit: BoxFit.cover, alignment: Alignment.topCenter);

  static final Image logoBar = Image.asset(_root + 'logo_menu.png');
  static final Image logoFull = Image.asset(_root+'logo_full.png');
  static final Image googleLogo = Image.asset(_root + 'google_logo.png', height: 25,);
  static final Image appleLogo = Image.asset(_root + 'apple_logo.png', height: 25,);
  static final Image excDialogImage = Image.asset(_root+'evento.jpeg');
  static final Image ticketImage = Image.asset(_root+'foto_pulseirinha.jpg');
}