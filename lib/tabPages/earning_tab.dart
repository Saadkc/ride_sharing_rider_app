

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class EarningTabPage extends StatefulWidget {
  const EarningTabPage({Key? key}) : super(key: key);

  @override
  State<EarningTabPage> createState() => _EarningTabPageState();
}

class _EarningTabPageState extends State<EarningTabPage> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.7848,67.1259),
    zoom: 13.4746,
  );
  final List<Marker> _markers = [
    Marker(markerId: MarkerId('1'),
      position: LatLng(24.7848,67.1259),
      infoWindow: InfoWindow(
          title: 'KIET MAIN CAMPUS'
      ),
    ),
  ];
  loadData() {
    getUserCurrentLocation().then((value)async{
      print(value.latitude.toString()+""+value.longitude.toString());
      _markers.add(
          Marker(
              markerId: MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                  title: 'MY CURRENT LOCATION'
              )
          )
      );
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(value.latitude, value.longitude));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });


  }
@override
void initState(){
    super.initState();
    loadData();
}

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
        onPressed: () async
        {
          getUserCurrentLocation().then((value)async{
            print(value.latitude.toString()+""+value.longitude.toString());
            _markers.add(
                Marker(
                    markerId: MarkerId('2'),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: InfoWindow(
                        title: 'MY CURRENT LOCATION'
                    )
                )
            );
            CameraPosition cameraPosition = CameraPosition(
              zoom: 14,
                target: LatLng(value.latitude, value.longitude));
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });
          });

        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}

