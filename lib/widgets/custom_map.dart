import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap>
{
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _location = LatLng(-1.306878, -48.027989);

  static final CameraPosition _initialLocation = CameraPosition
  (
    target: _location,
    zoom: 10,
  );

  static Future<void> openMap() async
  {
    String url = 'geo:${_location.latitude},${_location.longitude}';
    if (await canLaunch(url))
    {
      await launch(url);
    }
    else
    {
      throw 'Could not open the map.';
    }
  }

  MapType mapType;

  final Set<Marker> _markers = {};
  void initMarker()
  {
    _markers.add(Marker
    (
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_location.toString()),
      position: _location,
      infoWindow: InfoWindow(
        title: 'Guará Acqua Park',
        snippet: 'Parque Aquático e Restaurante'
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  @override
  void initState()
  {
    super.initState();
    mapType = MapType.normal;
    initMarker();
  }

  @override
  Widget build(BuildContext context)
  {

    return Scaffold
    (
      body: Stack
      (
        alignment: Alignment.topRight,
        children: <Widget>
        [
          GoogleMap
          (
            mapType: mapType,
            initialCameraPosition: _initialLocation,
            onMapCreated: (GoogleMapController controller)
            {
              _controller.complete(controller);
            },
            markers: _markers,
          ),
          IconButton
          (
            icon: Icon(Icons.repeat, color: Colors.blue,),
            onPressed: ()
            {
              setState(()
              {
                if(mapType == MapType.hybrid) mapType = MapType.normal;
                else mapType = MapType.hybrid;
              });
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended
      (
        onPressed: openMap,
        label: Text('Venha até nós!'),
        icon: Icon(Icons.directions_bus),
      ),
    );
  }
}
