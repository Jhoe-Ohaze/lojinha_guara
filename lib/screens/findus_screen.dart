import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindUsScreen extends StatefulWidget {
  @override
  _FindUsScreenState createState() => _FindUsScreenState();
}

class _FindUsScreenState extends State<FindUsScreen>
{
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialLocation = CameraPosition
  (
    target: LatLng(-1.3068844, -48.0280005),
    zoom: 17,
  );

  Widget customMap()
  {
    return Scaffold
    (
      body: GoogleMap
        (
        mapType: MapType.hybrid,
        initialCameraPosition: _initialLocation,
        onMapCreated: (GoogleMapController controller)
        {
          _controller.complete(controller);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>
      [
        SizedBox
        (
          height: MediaQuery.of(context).size.height*0.4,
          child: Container
            (
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration
                (
                border: Border.all(color: Colors.grey),
              ),
              child: customMap()
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
