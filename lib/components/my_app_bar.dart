import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

AppBar myAppBar(BuildContext context, {String? title}) {
  User? user = context.select((value) => null);
  return AppBar(
      systemOverlayStyle:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? const SystemUiOverlayStyle(
                  // // Status bar brightness (optional)
                  statusBarIconBrightness:
                      Brightness.dark, // For Android (dark icons)
                  statusBarBrightness: Brightness.light, // For iOS (dark icons)
                )
              : null,
      title: Text(title ?? AppLocalizations.of(context)!.noTitle),
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.white
              : Colors.black);
}
