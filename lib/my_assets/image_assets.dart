import 'package:flutter/material.dart';

class ImageAssets
{
  static String _root = "lib/my_assets/images/";
  static Image menuImage(width) => Image.asset(_root+'menu.png',
      alignment: Alignment.topLeft, width: width, fit: BoxFit.fill);

  static Image logoImage = Image.asset(_root+'logo_drawer.png',
      alignment: Alignment.bottomCenter);

  static Image sendButtonImage = Image.asset(_root+'send_button.png',
      fit: BoxFit.fill, color: Color.fromRGBO(255, 255, 255, 0.8),
      colorBlendMode: BlendMode.modulate);

  static Image testFeedImage = Image.asset(_root+'test_feed.jpg',
      fit: BoxFit.cover, alignment: Alignment.topCenter);

  static Image excDialogImage = Image.asset(_root+'evento.jpeg');
  static Image ticketImage = Image.asset(_root+'foto_pulseirinha.jpg');
}