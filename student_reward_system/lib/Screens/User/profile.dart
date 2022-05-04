import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome! ',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(children: <Widget>[]),
        ));
  }
}
