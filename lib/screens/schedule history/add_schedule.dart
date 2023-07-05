import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rider/global/global.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController fromLocation = TextEditingController();
  TextEditingController toLocation = TextEditingController();
  TextEditingController faresController = TextEditingController();
  String selectedSeats = "1";
  bool? isDaily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Schedule"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                if (fromLocation.text.isEmpty ||
                    toLocation.text.isEmpty ||
                    faresController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please fill all the fields");
                  return;
                } else if (isDaily == null ||
                    _selectedTime == null ||
                    _selectedDate == null) {
                  Fluttertoast.showToast(msg: "Please fill all the fields");
                  return;
                } else {
                  await FirebaseDatabase.instance
                      .ref()
                      .child("schedule")
                      .child(currentFirebaseUser!.uid)
                      .push()
                      .set({
                    "fromLocation": fromLocation.text,
                    "toLocation": toLocation.text,
                    "seats": selectedSeats,
                    "isDaily":
                        isDaily != null && isDaily == true ? "true" : "false",
                    "date":
                        DateFormat.yMMMd().format(_selectedDate!).toString(),
                    "time": TimeOfDay(
                            hour: _selectedTime!.hour,
                            minute: _selectedTime!.minute)
                        .format(context)
                        .toString(),
                    "fares": faresController.text,
                  }).then((value) {
                    Fluttertoast.showToast(msg: "Schedule Submitted");
                    Navigator.pop(context);
                  });
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
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
                  controller: fromLocation,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on_outlined),
                    labelText: "Add Pickup Location",
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
                TextFormField(
                  controller: toLocation,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on_outlined),
                    labelText: "Add Dropoff Location",
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Select Seats",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: selectedSeats,
                      items: <String>['1', '2', '3', '4'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSeats = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDaily = true;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isDaily != null && isDaily == true
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
                              color: isDaily != null && isDaily == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDaily = false;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isDaily != null && isDaily == false
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
                              color: isDaily != null && isDaily == false
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
                      _selectedDate == null
                          ? "Select Date"
                          : DateFormat.yMMMd()
                              .format(_selectedDate!)
                              .toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () async {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100))
                              .then((value) => setState(() {
                                    _selectedDate = value!;
                                  }));
                        },
                        child: const Icon(Icons.calendar_today_outlined))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      _selectedTime == null
                          ? "Select Time"
                          : TimeOfDay(
                                  hour: _selectedTime!.hour,
                                  minute: _selectedTime!.minute)
                              .format(context)
                              .toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () async {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute))
                              .then((value) => setState(() {
                                    _selectedTime = value!;
                                  }));
                        },
                        child: const Icon(Icons.timer_outlined))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Adjust Your Fares /Km",
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
                          labelText: "Add Fares",
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
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
