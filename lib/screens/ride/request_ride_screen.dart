import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestRide extends StatefulWidget {
  const RequestRide({super.key});

  @override
  State<RequestRide> createState() => _RequestRideState();
}

class _RequestRideState extends State<RequestRide> {
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

            Map data = snapshot.data!.snapshot.value;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "Name: ${data.values.elementAt(index)['name'].toString()}"),
                      subtitle: Text(
                          "Phone : ${data.values.elementAt(index)['phone'].toString()}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child("requestRides")
                                    .child(data.keys.elementAt(index))
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
                                    .child(data.keys.elementAt(index))
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
