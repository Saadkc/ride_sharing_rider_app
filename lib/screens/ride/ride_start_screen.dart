import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import '../../assistants/assistant_methods.dart';
import '../../global/global.dart';
import '../../models/active_nearby_drivers.dart';
import 'end_ride.dart';
import 'dart:math' show cos, sqrt, asin;

class RideStartScreen extends StatefulWidget {
  final Map data;
  const RideStartScreen({super.key, required this.data});

  @override
  State<RideStartScreen> createState() => _RideStartScreenState();
}

class _RideStartScreenState extends State<RideStartScreen> {
  GoogleMapController? newGoogleMapController;
  TextEditingController controller = TextEditingController();
  double searchLocationContainerHeight = 260;
  double bottomPaddingOfMap = 0;
  CameraPosition? _initialPosition;
  String userName = "your Name";
  String userEmail = "your Email";
  Set<Polyline> polyLineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  Map data = {};
  loc.Location location = loc.Location();
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  List<LatLng> pLineCoOrdinatesList = [];

  bool openNavigationDrawer = true;

  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;

  void callNumber(String phoneNumber) async {
    String number = phoneNumber; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  void checkRideAccepted() async {
    loc.LocationData locationData = await location.getLocation();
    dynamic ref = FirebaseDatabase.instance
        .ref()
        .child("requestRides")
        .child(widget.data['user_id'])
        .onValue;

    ref.listen((event) {
      String status = event.snapshot.value["status"].toString();
      double driverLat = locationData.latitude!;
      double driverLng = locationData.longitude!;

      if (status == "arrived") {
        event.snapshot.ref.update({
          'driver_lat': driverLat,
          'driver_lng': driverLng,
        });
        drawPolyLineFromOriginToDestination(event.snapshot.value);
      }
    });
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng latLngPosition = LatLng(cPosition.latitude, cPosition.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    setState(() {
      _initialPosition = cameraPosition;
    });
  }

  @override
  void initState() {
    locateUserPosition();
    checkRideAccepted();
    super.initState();
  }

  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<dynamic>(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child("requestRides")
                  .child(widget.data['user_id'])
                  .onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                data = snapshot.data.snapshot.value;

                return Stack(children: [
                  GoogleMap(
                    padding: EdgeInsets.only(bottom: bottomPaddingOfMap),

                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: _initialPosition!,
                    polylines: polyLineSet,
                    // markers: markers,
                    markers: Set.from(markersSet),
                    circles: circlesSet,
                    onMapCreated: (GoogleMapController controller) async {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      await drawPolyLineFromOriginToDestination(data);

                      blackThemeGoogleMap();

                      setState(() {
                        bottomPaddingOfMap = 240;
                      });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedSize(
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 120),
                        child: Container(
                          height: searchLocationContainerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),

                                //from
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Passenger Name: ${widget.data["passenger_name"]}",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "Passenger Phone: ${widget.data["passenger_phone"]}",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          callNumber(
                                              widget.data["passenger_phone"]);
                                        },
                                        child: const Icon(Icons.call,
                                            color: Colors.green))
                                  ],
                                ),

                                const SizedBox(height: 20.0),

                                Container(
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 15.0),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10.0),
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Text(
                                              "from: ${widget.data["pickupLocation"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5.0),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Divider(
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                      (data['status'] == "accepted")
                                          ? const SizedBox.shrink()
                                          : Row(
                                              children: [
                                                const SizedBox(width: 10.0),
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 10.0),
                                                Expanded(
                                                  child: Text(
                                                    "To: ${widget.data["dropOffLocation"]}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      const SizedBox(height: 5.0),
                                      (data['status'] == "accepted")
                                          ? const SizedBox.shrink()
                                          : const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              child: Divider(
                                                color: Colors.white,
                                                height: 1,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20.0),
                                InkWell(
                                  onTap: () {
                                    User user =
                                        FirebaseAuth.instance.currentUser!;

                                    if (data['status'] == "accepted") {
                                      FirebaseDatabase.instance
                                          .ref()
                                          .child("requestRides")
                                          .child(widget.data["user_id"])
                                          .update({
                                        "status": "arrived",
                                      }).then((value) {
                                        Fluttertoast.showToast(
                                            msg: "Arrived User Lcoation");
                                        setState(() {});
                                      });
                                    } else {
                                      double km = calculateDistance(widget.data['fromLatitude'], widget.data['fromLongitute'], widget.data['toLatitude'], widget.data['toLongitute']);
                                      km = km * 20;
                                      FirebaseDatabase.instance
                                          .ref()
                                          .child("requestRides")
                                          .child(widget.data["user_id"])
                                          .update({
                                            "status": "completed",
                                          })
                                          .then((value) =>
                                              Fluttertoast.showToast(
                                                  msg: "Ride Completed"))
                                          .then((value) =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EndRide(
                                                            km: km,
                                                            data: widget.data,
                                                          ))));
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        data['status'] == "accepted"
                                            ? "Arrived at pickup location"
                                            : "End Ride",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ]);
              }),
    );
  }

  Future<void> drawPolyLineFromOriginToDestination(Map data) async {
    var originLatLng = LatLng(data['fromLatitude'], data['fromLongitute']);
    var destinationLatLng;
    if (data['status'] == "accepted") {
      destinationLatLng = LatLng(data['driver_lat'], data['driver_lng']);
    } else {
      destinationLatLng = LatLng(data['toLatitude'], data['toLongitute']);
    }

    List<ActiveNearbyAvailableDrivers> drivers = [];

    drivers.add(
      ActiveNearbyAvailableDrivers(
        driverId: "",
        locationLatitude: destinationLatLng.latitude,
        locationLongitude: destinationLatLng.longitude,
      ),
    );

    drivers.add(
      ActiveNearbyAvailableDrivers(
        driverId: "",
        locationLatitude: originLatLng.latitude,
        locationLongitude: originLatLng.longitude,
      ),
    );

    displayActiveDriversOnUsersMap(drivers);

    var directionDetailsInfo =
        await AssistantMethods.obtainOriginToDestinationDirectionDetails(
            originLatLng, destinationLatLng);

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResultList =
        pPoints.decodePolyline(directionDetailsInfo!.e_points!);

    pLineCoOrdinatesList.clear();

    if (decodedPolyLinePointsResultList.isNotEmpty) {
      decodedPolyLinePointsResultList.forEach((PointLatLng pointLatLng) {
        pLineCoOrdinatesList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.purpleAccent,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoOrdinatesList,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    LatLngBounds boundsLatLng;
    if (originLatLng.latitude > destinationLatLng.latitude &&
        originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
        northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
      );
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
        northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      boundsLatLng =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }

    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));

    Marker originMarker = Marker(
      markerId: const MarkerId("originID"),
      infoWindow: InfoWindow(title: data['pickupLocation'], snippet: "Origin"),
      position: originLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId("destinationID"),
      infoWindow:
          InfoWindow(title: data['dropOffLocation'], snippet: "Destination"),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    setState(() {
      markersSet.add(originMarker);
      markersSet.add(destinationMarker);
    });

    Circle originCircle = Circle(
      circleId: const CircleId("originID"),
      fillColor: Colors.green,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: originLatLng,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId("destinationID"),
      fillColor: Colors.red,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: destinationLatLng,
    );

    setState(() {
      circlesSet.add(originCircle);
      circlesSet.add(destinationCircle);
    });
  }

  displayActiveDriversOnUsersMap(List<ActiveNearbyAvailableDrivers> drivers) {
    markersSet.clear();
    circlesSet.clear();

    Set<Marker> driversMarkerSet = Set<Marker>();

    for (var element in drivers) {
      LatLng eachDriverActivePosition =
          LatLng(element.locationLatitude!, element.locationLongitude!);

      Marker marker = Marker(
        markerId: MarkerId("driver${element.driverId!}"),
        position: eachDriverActivePosition,
        // icon: activeNearbyIcon!,
        rotation: 360,
      );

      driversMarkerSet.add(marker);
    }

    markersSet = driversMarkerSet;

    setState(() {});
  }
}
