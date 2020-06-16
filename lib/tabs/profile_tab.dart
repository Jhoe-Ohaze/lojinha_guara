import 'package:flutter/material.dart';
import 'package:lojinha_guara/my_assets/icon_assets.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
import 'package:lojinha_guara/screens/excursion_screen.dart';
import 'package:lojinha_guara/screens/society_screen.dart';
import 'package:lojinha_guara/screens/ticket_screen.dart';
import 'package:lojinha_guara/widgets/custom_tile.dart';

class ProfileTab extends StatefulWidget
{
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
{
  Widget _googleButton()
  {
    return RaisedButton
    (
      elevation: 2,
      child: Container
      (
        child: Row
        (
          children: <Widget>
          [
            ImageAssets.googleLogo,
            SizedBox(height: 40, width: 1,),
            Expanded
            (
              child: Container
              (
                alignment: Alignment.center,
                child: Text("Entrar com o Google", style: TextStyle(fontSize: 16, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),),
              )
            )
          ]
        ),
      ),
      color: Colors.white,
      onPressed: ()
      {
      },
    );
  }

  Widget _appleButton()
  {
    return RaisedButton
    (
      elevation: 2,
      highlightColor: Colors.white30,
      child: SizedBox
      (
        height: 45,
        child: Row
        (
            children: <Widget>
            [
              ImageAssets.appleLogo,
              SizedBox(height: 40, width: 1,),
              Expanded
                (
                  child: Container
                  (
                    alignment: Alignment.center,
                    child: Text("Entrar com Apple ID", style: TextStyle
                      (fontSize: 16, fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold, color: Colors.white)),
                  )
              )
            ]
        )
      ),
      color: Colors.grey[800],
      onPressed: (){},
    );
  }

  Widget _loginTile()
  {
    return Column
      (
      children: <Widget>
      [
        Container
          (
            decoration: BoxDecoration
              (
                gradient: LinearGradient
                  (
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[700], Colors.cyan, Colors.white]
                )
            ),
            padding: EdgeInsets.all(35), child: ImageAssets.logoFull
        ),
        Container(padding: EdgeInsets.symmetric(horizontal: 25), child: _googleButton()),
        Container(padding: EdgeInsets.symmetric(horizontal: 25), child: _appleButton()),
      ],
    );
  }

  void _openTicketScreen()
  {
    Navigator.of(context).push(PageRouteBuilder
      (
        pageBuilder: (context, animation, secondaryAnimation) => PreLoadTicketScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve));

          return SlideTransition
            (
            position: animation.drive(tween),
            child: child,
          );
        }
    ));
  }

  void _openExcursionScreen()
  {
    Navigator.of(context).push(PageRouteBuilder
      (
        pageBuilder: (context, animation, secondaryAnimation) => ExcursionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve));

          return SlideTransition
            (
            position: animation.drive(tween),
            child: child,
          );
        }
    ));
  }

  void _openSocietyScreen()
  {
    Navigator.of(context).push(PageRouteBuilder
    (
      pageBuilder: (context, animation, secondaryAnimation) => SocietyScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child)
      {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition
        (
          position: animation.drive(tween),
          child: child,
        );
      }
    ));
  }

  Widget _buildBody()
  {
    return Scaffold
    (
      body: ListView
      (
        children: <Widget>
        [
          _loginTile(),
          Divider(),
          CustomTile(IconAssets.ticket, "Comprar ingresso", _openTicketScreen),
          Divider(),
          CustomTile(Icons.beach_access, "Marcar uma excursao", _openExcursionScreen),
          Divider(),
          CustomTile(Icons.person, "Quero ser socio!", _openSocietyScreen),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildBody();
  }
}
