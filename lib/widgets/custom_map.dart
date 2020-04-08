import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class CustomMap extends StatefulWidget
{
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap>
{
  Icon buttonIcon = Icon(Icons.satellite);

  Completer<GoogleMapController> _controller = Completer();
  static LatLng _location = LatLng(-1.306878, -48.027989);

  static final CameraPosition _initialLocation = CameraPosition
  (
    target: _location,
    zoom: 13,
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
      markerId: MarkerId(_location.toString()),
      position: _location,
      infoWindow: InfoWindow
      (
        title: 'Guará Acqua Park',
        snippet: 'Parque Aquático e Restaurante'
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  Future<void> centerLocation() async
  {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_initialLocation));
  }
  @override
  void initState()
  {
    super.initState();
    mapType = MapType.hybrid;
    initMarker();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Stack
      (
        alignment: Alignment.bottomRight,
        children: <Widget>
        [
          GoogleMap
          (
            indoorViewEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference(9, 30),
            mapType: mapType,
            initialCameraPosition: _initialLocation,
            onMapCreated: (GoogleMapController controller)
            {
              _controller.complete(controller);
            },
            markers: _markers,
            buildingsEnabled: false,
          ),
          Container
          (
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04, vertical: 75),
            child: Row
            (
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>
              [
                FloatingActionButton.extended
                (
                  onPressed: (){centerLocation();},
                  icon: Icon(Icons.my_location),
                  label: Text("Centralizar"),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Row
        (
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>
        [
          FloatingActionButton
            (
            child: buttonIcon,
            onPressed: ()
            {
              setState(()
              {
                if(mapType == MapType.hybrid)
                {
                  mapType = MapType.normal;
                  buttonIcon = Icon(Icons.satellite);
                }
                else
                {
                  mapType = MapType.hybrid;
                  buttonIcon = Icon(Icons.map);
                }
              });
            },
          ),
          Container(width: 5, height: 10,),
          FloatingActionButton.extended
            (
              onPressed: openMap,
              label: Text('Venha até nós!'),
              icon: Icon(Icons.directions_bus)
          ),
        ],
      )
    );
  }
}
