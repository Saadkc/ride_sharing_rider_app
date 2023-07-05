import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../global/global.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  TextEditingController fromLocationController = TextEditingController();
  TextEditingController toLocationController = TextEditingController();
  TextEditingController faresController = TextEditingController();
  String isDaily = "";

  @override
  Widget build(BuildContext context) {
    print(currentFirebaseUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        centerTitle: true,
      ),
      body: StreamBuilder<dynamic>(
          stream: FirebaseDatabase.instance
              .ref()
              .child("schedule")
              .child(currentFirebaseUser!.uid)
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data!.snapshot.value == null) {
              return const Center(
                  child: Text('No Schdule available right now'));
            }

            Map data = snapshot.data!.snapshot.value;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  fromLocationController.text =
                      data.values.elementAt(index)['fromLocation'];
                  toLocationController.text =
                      data.values.elementAt(index)['toLocation'];
                  isDaily = data.values.elementAt(index)['isDaily'];
                  faresController.text =
                      data.values.elementAt(index)['fares'];
                  return Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    height: 480,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: fromLocationController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.location_on_outlined),
                            labelText: "Pickup Location",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: toLocationController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.location_on_outlined),
                            labelText: "DropOff Location",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Seats",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            Text(data.values.elementAt(index)['seats'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isDaily == "true"
                                    ? Colors.blue
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Daily",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isDaily == "true"
                                          ? Colors.white
                                          : Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isDaily == "false"
                                    ? Colors.blue
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "One Time",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDaily == "false"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              data.values.elementAt(index)['date'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            const Icon(Icons.calendar_today_outlined)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              data.values.elementAt(index)['time'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            const Icon(Icons.timer_outlined)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Fares /Km",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: TextFormField(
                                controller: faresController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  labelText: "Fares",
                                  // hintText: "Select From Location",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
