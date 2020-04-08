import 'package:flutter/material.dart';

class ImageAssets
{
  static Image menuImage(width) => Image.asset('lib/my_assets/images/menu.png',
      alignment: Alignment.topLeft, width: width, fit: BoxFit.fill);

  static Image logoImage = Image.asset('lib/my_assets/images/logo_drawer.png',
      alignment: Alignment.bottomCenter);

  static Image sendButtonImage = Image.asset('lib/my_assets/images/send_button.png',
      fit: BoxFit.fill, color: Color.fromRGBO(255, 255, 255, 0.8),
      colorBlendMode: BlendMode.modulate);

  static Image excDialogImage = Image.asset('lib/my_assets/images/evento.jpeg');
  static Image ticketImage = Image.asset('lib/my_assets/images/foto_pulseirinha.jpg');
}