import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rider/screens/mainScreens/main_screen.dart';
import 'package:rider/splashScreen/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "kiet-ride-sharing-app",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(
      child: MaterialApp(
    title: 'Drivers App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const MySplashScreen(),////
    debugShowCheckedModeBanner: false,
  )));
}

class MyApp extends StatefulWidget {
  final Widget? child;

  MyApp({this.child});
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }
  //const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      child: widget.child!,
    );
  }
}
