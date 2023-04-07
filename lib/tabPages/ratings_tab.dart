import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider/widgets/progress_dialog.dart';

class RaitingsTabPage extends StatefulWidget {
  const RaitingsTabPage({Key? key}) : super(key: key);

  @override
  State<RaitingsTabPage> createState() => _RaitingsTabPageState();
}

class _RaitingsTabPageState extends State<RaitingsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rating')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const SizedBox(height: 30),
            // * rating Bar Change
            const Text('Rate the rider'),
            RatingBar.builder(
              itemCount: 5,
              initialRating: 2,
              minRating: 1,
              allowHalfRating: true,
              direction: Axis.horizontal,
              itemPadding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {
                print(value);
              },
            ),
            const SizedBox(height: 30),
            // * rating Bar Change
            const Text('How was your experience'),
            RatingBar.builder(
              initialRating: 3,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return const Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return const Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return const Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return const Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                  default:
                    return const Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
              },
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            ElevatedButton(
              child: const Text(
                "Submit rating",
              ),
              onPressed: ()
              {
                Fluttertoast.showToast(msg: "Submitting Raiting please wait for the  response");
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext c)
                    {
                      return ProgressDialogue(message: "Processing, please Wait",);
                    }
                );

              },
            ),
          ],
        ),

      ),


    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class RaitingsTabPage extends StatelessWidget {
//   const RaitingsTabPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Rating')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // * rating Bar
//             const Text('Rating Bar'),
//             RatingBarIndicator(
//               rating: 3,
//               itemCount: 5,
//               itemSize: 50,
//               direction: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return const Icon(Icons.star, color: Colors.amber);
//               },
//             ),
//
//             const SizedBox(height: 30),
//             // * rating Bar Change
//             const Text('Rating Bar Change'),
//             RatingBar.builder(
//               itemCount: 5,
//               initialRating: 2,
//               minRating: 1,
//               allowHalfRating: true,
//               direction: Axis.horizontal,
//               itemPadding: const EdgeInsets.symmetric(horizontal: 8),
//               itemBuilder: (context, index) => const Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (value) {
//                 print(value);
//               },
//             ),
//             const SizedBox(height: 30),
//             // * rating Bar Change
//             const Text('Rating Bar Face'),
//             RatingBar.builder(
//               initialRating: 3,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 switch (index) {
//                   case 0:
//                     return const Icon(
//                       Icons.sentiment_very_dissatisfied,
//                       color: Colors.red,
//                     );
//                   case 1:
//                     return const Icon(
//                       Icons.sentiment_dissatisfied,
//                       color: Colors.redAccent,
//                     );
//                   case 2:
//                     return const Icon(
//                       Icons.sentiment_neutral,
//                       color: Colors.amber,
//                     );
//                   case 3:
//                     return const Icon(
//                       Icons.sentiment_satisfied,
//                       color: Colors.lightGreen,
//                     );
//                   case 4:
//                     return const Icon(
//                       Icons.sentiment_very_satisfied,
//                       color: Colors.green,
//                     );
//                   default:
//                     return const Icon(
//                       Icons.sentiment_very_satisfied,
//                       color: Colors.green,
//                     );
//                 }
//               },
//               onRatingUpdate: (rating) {
//                 print(rating);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
