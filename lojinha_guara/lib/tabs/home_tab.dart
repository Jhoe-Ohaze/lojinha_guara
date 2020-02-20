import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductTab extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return TabBody();
  }

  Widget TabBody()
  {
    return Column
    (
      children: <Widget>
      [
        AppBar
        (
          title: Text
          (
            "Bilheteria",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
          centerTitle: true,
        ),
        Stack
        (
          children: <Widget>
          [
            Container(color: Color(0xFF88BBDD)),
            Expanded
            (
              child: FutureBuilder<QuerySnapshot>
              (
                future: Firestore.instance.collection("market_images").orderBy("id").getDocuments(),
                builder: (context, snapshot)
                {
                  if(!snapshot.hasData)
                  {
                    return Expanded(child: Center(child: CircularProgressIndicator()));
                  }
                  else
                  {
                    List<DocumentSnapshot> tempList = snapshot.data.documents;
                    return MaterialButton
                    (
                      child: GridView.builder
                      (
                        padding: EdgeInsets.all(10.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                        (
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: tempList.length,
                        itemBuilder: (context, index)
                        {
                          Iterable<String> imageUrl = snapshot.data.documents.map((doc){return doc.data["url"];});
                          return GestureDetector
                          (
                            child: Stack
                            (
                              children: <Widget>
                              [
                                FadeInImage.memoryNetwork
                                (
                                  placeholder: kTransparentImage,
                                  image: imageUrl.elementAt(index),
                                  height: 300.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          );
                        }
                      )
                    );
                  }
                }
              ),
            )
          ],
        )
      ],
    );
  }
}

