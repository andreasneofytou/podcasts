import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FilledButton(
        child: const Text('Sign out'),
        onPressed: () {
          _auth.signOut();
        },
      )),
    );
  }
}
