import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider/splashScreen/splash_screen.dart';
import 'firebase_options.dart';
import 'global/global.dart';

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
    home: const MySplashScreen(), ////
    debugShowCheckedModeBanner: false,
  )));
}

class MyApp extends StatefulWidget {
  final Widget? child;
  const MyApp({super.key, this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }
  //const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    final isResumed = state == AppLifecycleState.resumed;
    final isClosed = state == AppLifecycleState.inactive;

    if (isClosed) {
      print("App is in Inactive Mode");//Inactive
    } else if(isResumed){
      print("App is in Foreground Mode");
    } else if(isBackground) {
      print("App is in Background Mode");
      await FirebaseDatabase.instance
        .ref()
        .child('activeDrivers')
        .child(currentFirebaseUser!.uid).remove();

    } else {
      print("App is in Detached Mode");
    }

    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      child: widget.child!,
    );
  }
}
