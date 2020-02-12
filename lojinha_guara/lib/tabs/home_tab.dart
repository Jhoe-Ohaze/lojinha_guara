import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    double screenHeight = MediaQuery.of(context).size.height;

    Widget _buildBodyBack() => Container
    (
      decoration: BoxDecoration
      (
        gradient: LinearGradient
        (
          colors:
          [
            Color(0xFF4580CA),
            Color(0xFF9AD2FA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
    );

    return Stack
    (
      children: <Widget>
      [
        _buildBodyBack(),
        CustomScrollView
        (
          slivers: <Widget>
          [
            SliverAppBar
            (
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar
              (
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            
            FutureBuilder<QuerySnapshot>
            (
              future: Firestore.instance.collection("homeImages").orderBy("id").getDocuments(),
              builder: (context, snapshot)
              {
                if(!snapshot.hasData)
                {
                  Firestore.instance
                      .collection('tasks')
                      .add({
                    "title": "oi",
                    "description": "oi"
                  });
                  return SliverToBoxAdapter
                  (
                    child: Container
                    (
                      alignment: Alignment.bottomCenter,
                      height: screenHeight/2 - screenHeight*0.0625,
                      child: CircularProgressIndicator
                      (
                        valueColor: AlwaysStoppedAnimation<Color>
                        (
                          Colors.white
                        ),
                      ),
                    ),
                  );
                }
                else if(snapshot.data.documents.isEmpty)
                {
                  return SliverToBoxAdapter
                  (
                    child: Container
                    (
                      color: Colors.green,
                      height: 200.0,
                    ),
                  );
                }
                else
                {
                  return SliverStaggeredGrid.count
                  (
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map
                    (
                      (doc)
                      {
                        return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                      }
                    ).toList(),
                    children: snapshot.data.documents.map
                    (
                      (doc)
                      {
                        return Container(height: 200, color: Colors.green,);
                      },
                    ).toList(),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
