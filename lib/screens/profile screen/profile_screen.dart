import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../global/global.dart';
import '../../splashScreen/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: StreamBuilder<dynamic>(
            stream: FirebaseDatabase.instance
                .ref()
                .child("drivers")
                .child(currentFirebaseUser!.uid)
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Center(
                    child: Text('No Schdule available right now'));
              }

              Map data = snapshot.data!.snapshot.value;

              nameController.text = data['name'];
              emailController.text = data['email'];
              phoneController.text = data['phone'];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseDatabase.instance
                                .ref()
                                .child("drivers")
                                .child(currentFirebaseUser!.uid)
                                .update({
                              'name': nameController.text,
                              'email': emailController.text,
                              'phone': phoneController.text,
                            }).then((value) => Fluttertoast.showToast(msg: "Profile Updated"));
                          },
                          child: const Text('Update'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            fAuth.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const MySplashScreen()));
                          },
                          child: const Text('Sign out'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
