import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
  //---------------------------------------------- for 2
  DateTime? _selectedDate1;
  TimeOfDay? _selectedTime1;
  TextEditingController fromLocation1 = TextEditingController();
  TextEditingController toLocation1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Schedule"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                if (fromLocation1.text.isNotEmpty) {
                  print("2nd schedule");
                  await FirebaseDatabase.instance
                      .ref()
                      .child("schedule")
                      .child(currentFirebaseUser!.uid)
                      .push()
                      .set({
                    "fromLocation": fromLocation.text,
                    "toLocation": toLocation.text,
                    "date":
                        DateFormat.yMMMd().format(_selectedDate!).toString(),
                    "time": TimeOfDay(
                            hour: _selectedTime!.hour,
                            minute: _selectedTime!.minute)
                        .format(context)
                        .toString(),
                  }).then((value) async {
                    await FirebaseDatabase.instance
                        .ref()
                        .child("schedule")
                        .child(currentFirebaseUser!.uid)
                        .push()
                        .set({
                      "fromLocation1": fromLocation1.text,
                      "toLocation1": toLocation1.text,
                      "date1": _selectedDate1 == null
                          ? ""
                          : DateFormat.yMMMd()
                              .format(_selectedDate1!)
                              .toString(),
                      "time1": _selectedTime1 == null
                          ? ""
                          : TimeOfDay(
                                  hour: _selectedTime1!.hour,
                                  minute: _selectedTime1!.minute)
                              .format(context)
                              .toString(),
                    }).then((value) => Navigator.pop(context));
                  });
                } else {
                  await FirebaseDatabase.instance
                      .ref()
                      .child("schedule")
                      .child(currentFirebaseUser!.uid)
                      .push()
                      .set({
                    "fromLocation": fromLocation.text,
                    "toLocation": toLocation.text,
                    "date":
                        DateFormat.yMMMd().format(_selectedDate!).toString(),
                    "time": TimeOfDay(
                            hour: _selectedTime!.hour,
                            minute: _selectedTime!.minute)
                        .format(context)
                        .toString(),
                  }).then((value) => Navigator.pop(context));
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
            height: 280,
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
                TextFormField(
                  controller: fromLocation,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on_outlined),
                    labelText: "Add From Location",
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
                    labelText: "Add To Location",
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
              ],
            ),
          ),
         
          const SizedBox(

            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.all(20),
            height: 280,
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
                Row(
                  children: [
                    Text(
                      _selectedDate1 == null
                          ? "Select Date"
                          : DateFormat.yMMMd()
                              .format(_selectedDate1!)
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
                                    _selectedDate1 = value!;
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
                      _selectedTime1 == null
                          ? "Select Time"
                          : TimeOfDay(
                                  hour: _selectedTime1!.hour,
                                  minute: _selectedTime1!.minute)
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
                                    _selectedTime1 = value!;
                                  }));
                        },
                        child: const Icon(Icons.timer_outlined))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: fromLocation1,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on_outlined),
                    labelText: "Add From Location",
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
                  controller: toLocation1,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on_outlined),
                    labelText: "Add To Location",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
