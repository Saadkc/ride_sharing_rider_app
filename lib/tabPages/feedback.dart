// import 'package:wiredash/wiredash.dart';
// import 'package:flutter/material.dart';
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return BetterFeedback(
//       theme: FeedbackThemeData(
//           background: const Color(0xff00569e),
//           drawColors: [
//             Colors.black87,
//             Colors.blue,
//             Colors.red,
//             Colors.green
//           ]
//       ),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   var image;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffff31b9),
//         title: const Text("Better Feedback"),
//       ),
//       body:  Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text("Hello From Salman",style: TextStyle(
//               fontSize: 24
//           ),),
//           ElevatedButton(onPressed: (){
//             BetterFeedback.of(context).show((p0) {
//               setState(() {
//                 image = p0.screenshot;
//               });
//               print(p0.text);
//             });
//           }, child: Text("Give Feedback"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffff31b9))),),
//           if(image!=null)
//             SizedBox(
//               height: 150,
//               child: Image.memory(image),
//             )
//         ],
//       ),
//     );
//   }
//
//
//
// }



