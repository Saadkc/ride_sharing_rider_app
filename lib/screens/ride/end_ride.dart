import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider/screens/mainScreens/main_screen.dart';

class EndRide extends StatelessWidget {
  final double km;
  final Map data;
  const EndRide({super.key, required this.km, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 40,
            width: size.width / 1.5,
            child: Row(
              children: [
                const Text(
                  "Total Cash",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  "RS ${km.toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 40,
          //   width: size.width / 1.5,
          //   child: Row(
          //     children: const [
          //       Text(
          //         "Pick-up Time:",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500),
          //       ),
          //       Spacer(),
          //       Text(
          //         "1:00 pm",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 40,
          //   width: size.width / 1.5,
          //   child: Row(
          //     children: const [
          //       Text(
          //         "Drop-off Time:",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500),
          //       ),
          //       Spacer(),
          //       Text(
          //         "1:30 pm",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: 50,
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseDatabase.instance
                      .ref()
                      .child("requestRides")
                      .child(data["user_id"])
                      .update({
                    "total_price": km.toStringAsFixed(2),
                  }).then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (route) => false));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0077B6),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: const Text(
                  "Confirm Payment",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
