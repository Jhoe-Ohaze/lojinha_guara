import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/my_assets/icon_assets.dart';
import 'package:lojinha_guara/my_assets/image_assets.dart';
import 'package:lojinha_guara/tabs/ticket_tab.dart';
import 'package:lojinha_guara/widgets/custom_bar.dart';
import 'package:lojinha_guara/widgets/custom_calendar.dart';
import 'package:lojinha_guara/widgets/custom_feed.dart';
import 'package:lojinha_guara/widgets/home_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatelessWidget
{
  final Function _setCurrentWidget;
  final id = 0;

  HomeTab(this._setCurrentWidget);

  @override
  Widget build(BuildContext context)
  {
    return _tabBody(context);
  }

  //////////////////////////////////////////////////////////////////////////////
  ////* Main Widget *///////////////////////////////////////////////////////////
  Widget _tabBody(context)
  {
    Future<void> openMap() async
    {
      String url = 'geo:${-1.306878},${-48.027989}';
      if (await canLaunch(url))
      {
        await launch(url);
      }
      else
      {
        throw 'Could not open the map.';
      }
    }

    Future<void> openLink() async
    {
      String link = "https://www.instagram.com/p/B-sLf8pBJw_/";
      if(await canLaunch(link))
      {
        launch(link);
      }
      else
      {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Não foi possível abrir")));
      }
    }

    Future<void> openFacebook() async
    {
      String link = "http://www.facebook.com/guarapark";
      if(await canLaunch(link))
      {
        launch(link);
      }
      else
      {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Não foi possível abrir")));
      }
    }

    Future<void> openInstagram() async
    {
      String link = "http://www.instagram.com/guarapark";
      if(await canLaunch(link))
      {
        launch(link);
      }
      else
      {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Não foi possível abrir")));
      }
    }

    void openTicketTab() => _setCurrentWidget(1, TicketTab());

    return Stack
    (
      children: <Widget>
      [
        SizedBox
        (
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView
            (
            physics: BouncingScrollPhysics(),
            child: Column
              (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                SizedBox(height: 120),

                ////////////////////////////////////////////////////////////////
                ////* Feed 1 *//////////////////////////////////////////////////
                Container
                (
                  margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                  child: CustomFeed
                  (
                    ImageAssets.testFeedImage,
                    "Titulo da noticia",
                    "Aqui vamos ter um resumo sobre a noticia, podemos descrever melhor a noticia anunciada anteriormente.",
                    "Botao muito doido",
                    openLink,
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////////
                ////* Home Buttons *////////////////////////////////////////////
                Container
                  (
                  margin: EdgeInsets.symmetric(vertical: 2.5),
                  child: Row
                    (
                    children: <Widget>
                    [
                      HomeButtons(openMap, Icons.directions_bus, "Venha até nós!", 1),
                      SizedBox(width: 15, height: 30),
                      HomeButtons(openTicketTab, IconAssets.ticket, "Compre seu bilhete!", 2),
                    ],
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////////
                ////* Calendar *////////////////////////////////////////////////
                SizedBox
                (
                  height: 450,
                  child: CustomCalendar(DateTime(2020, 12, 31)),
                ),
                ////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////////
                ////* Texto *///////////////////////////////////////////////////
                Container
                (
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Nos acompanhe nas Redes Sociais!", style: TextStyle
                    (fontFamily: 'Fredoka', fontSize: 30, color: Colors.grey[700]),
                      textAlign: TextAlign.center),
                ),
                ////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////////
                ////* Home Buttons Final *//////////////////////////////////////
                Container
                (
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row
                    (
                    children: <Widget>
                    [
                      HomeButtons(openFacebook, IconAssets.facebook, "Facebook", 1),
                      SizedBox(width: 15, height: 30),
                      HomeButtons(openInstagram, IconAssets.instagram, "Instagram", 2),
                    ],
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////

              ],
            ),
          ),
        ),
        CustomBar("Início"),
      ],
    );
  }
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
}