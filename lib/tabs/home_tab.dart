import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_guara/screens/product_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductTab extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return _tabBody();
  }

  ///////////////////////////////////////////////////
  /////////////////* Main Widget *///////////////////
  Widget _tabBody()
  {
    return Column
    (
      children: <Widget>
      [
        AppBar
          (
          backgroundColor: Color(0xFFEE3522),
          title: Text
            (
            "Bilheteria",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
          centerTitle: true,
        ),

        Expanded
        (
          child: Stack
            (
            children: <Widget>
            [
              _buildBackground(),
              _buildProducts(), //Products Slivers
            ],
          ),
        )
      ],
    );
  }
  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////

  ///////////////////////////////////////////////////
  //////////////////* Background *///////////////////
  Widget _buildBackground()
  {
    return Container
    (
      decoration: BoxDecoration
        (
          gradient: LinearGradient
          (
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
            [
              Color(0xFFAACCEE),
              Color(0xFFFFFFFF), 
            ]
        )
      ),
    ); //Background
  }
  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////

  ///////////////////////////////////////////////////
  ///////////////* Products Slivers *////////////////
  Widget _buildProducts()
  {
    return FutureBuilder<QuerySnapshot>
    (
      future: Firestore.instance.collection("market_images").orderBy("id").getDocuments(),
      builder: (context, snapshot)
      {
        if(!snapshot.hasData)
        {
          return Center(child: CircularProgressIndicator());
        }
        else
        {
          List<DocumentSnapshot> tempList = snapshot.data.documents;
          return GridView.builder
          (
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
            (
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: tempList.length,

            /////////////////////////////////////////////////////////
            /////////////////// Builder Function ////////////////////
            itemBuilder: (context, index)
            {
              Iterable<Map> productMap = snapshot.data.documents.map((doc){return doc.data;});
              return Stack
              (
                children: <Widget>
                [
                  ClipRRect
                  (
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack
                    (
                      children: <Widget>
                      [
                        FadeInImage.memoryNetwork
                        (
                          placeholder: kTransparentImage,
                          image: productMap.elementAt(index)["url"],
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Stack
                        (
                          children: <Widget>
                          [
                            Column
                              (
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>
                              [
                                Container
                                  (
                                  height: 70.0,
                                  color: Color(0xAA000000),
                                  child: Column
                                    (
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>
                                    [
                                      Padding
                                        (
                                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                                          child: Text
                                            (
                                            productMap.elementAt(index)["Nome"],
                                            style: TextStyle
                                              (
                                                fontSize: 20.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                      ),
                                      Padding
                                        (
                                          padding: EdgeInsets.symmetric(horizontal: 11.0),
                                          child: Text
                                            (
                                            "R\$" + productMap.elementAt(index)["preco"].toString(),
                                            style: TextStyle
                                              (
                                                fontSize: 15.0,
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        MaterialButton
                        (
                          height: double.infinity,
                          minWidth: double.infinity,
                          onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute
                              (builder: (context) => ProductScreen(productMap.elementAt(index))));
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          );
        }
      }
    );
  }
  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////
}

