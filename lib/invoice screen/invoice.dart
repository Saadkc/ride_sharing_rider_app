import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Ride Invoice',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Icon(
                Icons.inventory_rounded,
                color: Colors.black,
                size: 56,
              ),
            ),
            // const Align(
            //   alignment: Alignment.topCenter,
            //   child: Text(
            //     'Ride Invoice',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 28,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            const SizedBox(
              height: 30,
            ),
            TextRow('Booking ID', 'TRN122343'),
            TextRow('Distance Travelled', '1 KM'),
            TextRow('Time Taken', '0 mins'),
            TextRow('Base Fare', '\$ 86'),
            TextRow('Distance Fare', '\$13'),
            TextRow('Tax', '\$5'),
            TextRow('Tips', '\$5'),
            Total('Total', '\$105'),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextRow('Payment : CASH', 'CHANGE'),

            // TextRow(),
            const SizedBox(
              height: 60,
            ),
            InkWell(
                // onTap: () async { 
                //   final Uri url = Uri(scheme: 'tel', path: '24234 3545');
                //   if (await canLaunchUrl(url)) {
                //     await launchUrl(url);
                //   } else {
                //     print('Can not Launch this Url');
                //   }
                // },
                child: customButton())
          ]),
        ),
      ),
    );
  }
}

Widget TextRow(String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget Total(String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget customButton() {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.blue),
    child: const Center(
      child: Text(
        "Pay Now",
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
