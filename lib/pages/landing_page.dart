import 'package:flutter/material.dart';
import 'package:podcasts/pages/login_page.dart';
import 'package:podcasts/pages/sing_up_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isNewUser = false;

  @override
  Widget build(BuildContext context) {
    return isNewUser
        ? SignUpPage(loginAction: () {
            setState(() {
              isNewUser = false;
            });
          })
        : LoginPage(
            signUpAction: () {
              setState(() {
                isNewUser = true;
              });
            },
          );
  }
}
