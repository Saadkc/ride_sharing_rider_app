import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class HomeTabPage1 extends StatefulWidget {
  const HomeTabPage1({Key? key}) : super(key: key);

  @override
  State<HomeTabPage1> createState() => _HomeTabPage1State();
}

class _HomeTabPage1State extends State<HomeTabPage1> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.7848,67.1259),
    zoom: 13.4746,
  );
  List<Marker> _marker =[];
  final List<Marker> _list = const[
    Marker(markerId: MarkerId('1'),
      position: LatLng(24.925010472,67.1264648438),
      infoWindow: InfoWindow(
          title: 'Sana Sarah"s Salon & Studio'
      ),
    ),
    Marker(markerId: MarkerId('2'),
      position: LatLng(24.7785258094,67.0898493929),
      infoWindow: InfoWindow(
          title: 'Sara salon & spa'
      ),
    ),
    Marker(markerId: MarkerId('3'),
      position: LatLng(24.7921087119,67.0665040612),
      infoWindow: InfoWindow(
          title: 'Ilyas Salon'
      ),
    ),
    Marker(markerId: MarkerId('4'),
      position: LatLng(24.7928968661,67.0677423326),
      infoWindow: InfoWindow(
          title: 'Peng"s Salon'
      ),
    ),
    Marker(markerId: MarkerId('5'),
      position: LatLng( 24.816256,67.023373),
      infoWindow: InfoWindow(
          title: 'Saman"s Salon'
      ),
    ),
    Marker(markerId: MarkerId('6'),
      position: LatLng( 24.7953545, 67.0504457),
      infoWindow: InfoWindow(
          title: 'Wajid Khan Salon'
  ),
    ),
    Marker(markerId: MarkerId('7'),
      position: LatLng( 24.7953545, 67.0504457),
      infoWindow: InfoWindow(
          title: 'Meerab"s makeup Studio'
      ),
    ),
    Marker(markerId: MarkerId('8'),
      position: LatLng(24.90704647,67.11185253),
      infoWindow: InfoWindow(
          title: 'Natasha.B Salon & Spa'
      ),
    ),
    Marker(markerId: MarkerId('9'),
      position: LatLng(24.7971076741,67.0451831818),
      infoWindow: InfoWindow(
          title: 'Nadia"s Salon'
      ),
    ),
    Marker(markerId: MarkerId('10'),
      position: LatLng(24.8014112815,67.0735356191),
      infoWindow: InfoWindow(
          title: 'Maha Ali Bintory'
      ),
    ),

  ];


  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set<Marker>.of(_marker),


          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },

        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.location_disabled_outlined) ,
      //   onPressed: ()async
      //   {
      //     GoogleMapController controller = await _controller.future;
      //     controller.animateCamera(CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //           target: LatLng(24.8762,67.1013),
      //           zoom: 13.4746,
      //         )
      //     ));
      //     setState(() {
      //
      //     });
      //   },
      // ),
    );
  }
}
