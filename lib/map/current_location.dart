import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

class Current_location extends StatefulWidget {
  const Current_location({Key? key}) : super(key: key);

  @override
  State<Current_location> createState() => _Current_locationState();
}

class _Current_locationState extends State<Current_location> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.7848,67.1259),
    zoom: 13.4746,
  );
  final List<Marker> _markers = const[
  Marker(markerId: MarkerId('1'),
    position: LatLng(24.7848,67.1259),
    infoWindow: InfoWindow(
        title: 'KIET MAIN CAMPUS'
    ),
  ),
  ];


  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print('error'+error.toString());
    });
    return await Geolocator.getCurrentPosition();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          getUserCurrentLocation().then((value){
            print(value.latitude.toString()+""+value.longitude.toString());
            _markers.add(
              Marker(
                  markerId: const MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: 'MY CURRENT LOCATION'
                )
              )
            );
          });

        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
