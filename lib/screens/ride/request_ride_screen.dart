import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestRide extends StatefulWidget {
  const RequestRide({super.key});

  @override
  State<RequestRide> createState() => _RequestRideState();
}

class _RequestRideState extends State<RequestRide> {
  Map data = {};

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // Earth's radius in kilometers

    // Convert degrees to radians
    final lat1Rad = degreesToRadians(lat1);
    final lon1Rad = degreesToRadians(lon1);
    final lat2Rad = degreesToRadians(lat2);
    final lon2Rad = degreesToRadians(lon2);

    // Haversine formula
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Ride"),
        centerTitle: true,
      ),
      body: StreamBuilder<dynamic>(
          stream: FirebaseDatabase.instance.ref().child("requestRides").onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Center(
                  child: Text('No ride request available right now'));
            }

            data = snapshot.data!.snapshot.value;
            Map updatedData = {};

            updatedData = data;

            data.forEach((key, value) {
              double distanceInKm = calculateDistance(
                  value['fromLatitude'],
                  value['fromLongitute'],
                  value['toLatitude'],
                  value['toLongitute']);

              if (distanceInKm <= 10) {
                updatedData.remove(value['user_id']);
              } else {
                print("else");
              }
            });

            return ListView.builder(
                itemCount: updatedData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "Name: ${updatedData.values.elementAt(index)['passenger_name'].toString()}"),
                      subtitle: Text(
                          "Phone : ${updatedData.values.elementAt(index)['passenger_phone'].toString()}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child("requestRides")
                                    .child(updatedData.keys.elementAt(index))
                                    .update({"status": "accepted"}).then(
                                        (value) => Fluttertoast.showToast(
                                            msg: "Ride Accepted"));
                              },
                              child: const Text("Accept")),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child("requestRides")
                                    .child(updatedData.keys.elementAt(index))
                                    .update({"status": "Rejected"}).then(
                                        (value) => Fluttertoast.showToast(
                                            msg: "Ride Rejected"));
                              },
                              child: const Text("Reject")),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
