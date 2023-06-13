import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, this.loginAction});

  void Function()? loginAction;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
        email: usernameController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              AppLocalizations.of(context)!.signUpTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              controller: usernameController,
              obscureText: false,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context)!.usernameTitle)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context)!.passTitle)),
            ),
          ),
          FilledButton(
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: signUp,
              child: Text(AppLocalizations.of(context)!.signUp)),
          TextButton(
              onPressed: loginAction,
              child: Text(AppLocalizations.of(context)!.alreadyHaveAccount))
        ]),
      ),
    );
  }
}
